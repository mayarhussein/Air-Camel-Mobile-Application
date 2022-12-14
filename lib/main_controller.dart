import 'package:air_camel/models/account.dart';
import 'package:air_camel/models/address.dart';
import 'package:air_camel/models/categories.dart';
import 'package:air_camel/models/drawer/credit_transactions.dart';
import 'package:air_camel/models/drawer/offer.dart';
import 'package:air_camel/models/drawer/payments.dart';
import 'package:air_camel/models/notification.dart';
import 'package:air_camel/pages/client/client_navigation_screen.dart';
import 'package:air_camel/pages/company/company_navigation_home_screen.dart';
import 'package:air_camel/pages/company/edit_categories.dart';
import 'package:air_camel/pages/launch_app/auth_screen.dart';
import 'package:air_camel/pages/launch_app/splash_screen.dart';
import 'package:air_camel/providers/accounts_provider.dart';
import 'package:air_camel/providers/address_provider.dart';
import 'package:air_camel/providers/companies_provider.dart';
import 'package:air_camel/providers/credit_payments_provider.dart';
import 'package:air_camel/providers/notifications_provider.dart';
import 'package:air_camel/providers/offers_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/categories_provider.dart';

class MainController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // Life Listener
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_, userSanpshot) {
          if (userSanpshot.hasData) {
            // if (false) {
            final user = FirebaseAuth.instance.currentUser;
            CollectionReference usersData =
                FirebaseFirestore.instance.collection('users');
            return StreamBuilder<DocumentSnapshot>(
                stream: usersData.doc(user!.uid).snapshots(),
                builder: (ctx, usersSnapshot) {
                  if (usersSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return SplashScreen();
                  }
                  Map<String, dynamic> data =
                      usersSnapshot.data?.data() as Map<String, dynamic>;
                  if (data == null) {
                    return SplashScreen();
                  }
                  String role = data['role'];

                  Provider.of<AccountsProvider>(ctx, listen: false)
                      .createAccount(
                          id: user.uid,
                          firstName: data['firstName'],
                          lastName: data['lastName'],
                          email: data['email'],
                          password: data['password'],
                          phoneNumber: data['phoneNumber'],
                          image: data['image_url'],
                          role: role);

                  //------------------------------------------------------------------------

                  return StreamBuilder<QuerySnapshot>(
                      stream: usersData
                          .doc(user.uid)
                          .collection('notifications')
                          .snapshots(),
                      builder: (ctx, notificationsSnapshot) {
                        if (notificationsSnapshot.data == null) {
                          return SplashScreen();
                        }
                        List<NotificationModel> notificationList =
                            notificationsSnapshot.data!.docs.map((item) {
                          Timestamp stamp = item['dateTime'];
                          return NotificationModel(
                              id: item['id'],
                              message: item["message"],
                              subject: item["subject"],
                              idFrom: item["idFrom"],
                              idTo: item["idTo"],
                              dateTime:
                                  DateTime.parse(stamp.toDate().toString()),
                              isOpen: item["isOpen"]);
                        }).toList();
                        Provider.of<NotificationsProvider>(ctx)
                            .setNotifications(notificationList);
                        //---------------------------------------------------------------------------
                        return StreamBuilder<QuerySnapshot>(
                            stream: usersData
                                .doc(user.uid)
                                .collection('payments')
                                .snapshots(),
                            builder: (ctx, paymentsSnapshot) {
                              if (paymentsSnapshot.data == null) {
                                return SplashScreen();
                              }
                              List<PaymentModel> paymentsList =
                                  paymentsSnapshot.data!.docs.map((item) {
                                Timestamp stamp = item['dateTime'];
                                return PaymentModel(
                                    amount:
                                        double.parse(item["amount"].toString()),
                                    dateTime: DateTime.parse(
                                        stamp.toDate().toString()),
                                    idClient: item["idClient"],
                                    idCompany: item["idCompany"],
                                    companyName: item["companyName"]);
                              }).toList();
                              Provider.of<CreditPaymentsProvider>(ctx)
                                  .setPayments(paymentsList);
                              //------------------------------------------------------------------------------
                              CollectionReference offersData = FirebaseFirestore
                                  .instance
                                  .collection('offers');

                              return StreamBuilder<QuerySnapshot>(
                                  stream: offersData.snapshots(),
                                  builder: (ctx, offersSanpshot) {
                                    if (offersSanpshot.data == null) {
                                      return SplashScreen();
                                    }

                                    List<OfferModel> offersList =
                                        offersSanpshot.data!.docs.map((item) {
                                      Timestamp stamp1 = item['dateTime'];
                                      Timestamp stamp2 = item['expireTime'];

                                      return OfferModel(
                                          id: item['id'],
                                          idCompany: item['idCompany'],
                                          dateTime: DateTime.parse(
                                              stamp1.toDate().toString()),
                                          expireTime: DateTime.parse(
                                              stamp2.toDate().toString()),
                                          offerMsg: item['offerMsg'],
                                          isFeatured: item['isFeatured'],
                                          isExpired: DateTime.parse(
                                                  stamp2.toDate().toString())
                                              .isBefore(DateTime.now()));
                                    }).toList();
                                    Provider.of<OffersProvider>(ctx)
                                        .setOffers(offersList);
                                    //------------------------------------------------------------------
                                    return StreamBuilder<QuerySnapshot>(
                                        stream: usersData
                                            .doc(user.uid)
                                            .collection('credit_transactions')
                                            .snapshots(),
                                        builder:
                                            (ctx, creditTransactionsSnapshot) {
                                          if (creditTransactionsSnapshot.data ==
                                              null) {
                                            return SplashScreen();
                                          }
                                          List<CreditTransactionsModel>
                                              creditTransactionsList =
                                              creditTransactionsSnapshot
                                                  .data!.docs
                                                  .map((item) {
                                            Timestamp stamp = item['dateTime'];
                                            return CreditTransactionsModel(
                                                amount: double.parse(
                                                    item["amount"].toString()),
                                                dateTime: DateTime.parse(
                                                    stamp.toDate().toString()),
                                                reason: item['reason']);
                                          }).toList();
                                          Provider.of<CreditPaymentsProvider>(
                                                  ctx)
                                              .setCreditTransactions(
                                                  creditTransactionsList);
                                          //------------------------------------------------------------------
                                          if (role == 'client') {
                                            return StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('users')
                                                    .doc(user.uid)
                                                    .collection('address')
                                                    .snapshots(),
                                                builder:
                                                    (ctx, addressSanpshot) {
                                                  if (addressSanpshot.data ==
                                                      null) {
                                                    return SplashScreen();
                                                  }
                                                  List<AddressModel>
                                                      addressList =
                                                      addressSanpshot.data!.docs
                                                          .map((item) {
                                                    Timestamp stamp =
                                                        item['dateTime'];

                                                    return AddressModel(
                                                        id: item['id'],
                                                        idAccount:
                                                            item['idAccount'],
                                                        dateTime:
                                                            DateTime.parse(stamp
                                                                .toDate()
                                                                .toString()),
                                                        city: item['city'],
                                                        street: item['street'],
                                                        building:
                                                            item['building'],
                                                        floor: item['floor'],
                                                        apt: item['apt'],
                                                        other: item['other']);
                                                  }).toList();
                                                  Provider.of<AddressProvider>(
                                                          ctx)
                                                      .setAddress(addressList);

                                                  return StreamBuilder<
                                                          QuerySnapshot>(
                                                      stream:
                                                          usersData.snapshots(),
                                                      builder: (ctx,
                                                          allUsersSnapshot) {
                                                        if (allUsersSnapshot
                                                                .data ==
                                                            null) {
                                                          return SplashScreen();
                                                        }
                                                        List<Account?> list =
                                                            allUsersSnapshot
                                                                .data!.docs
                                                                .map((item) {
                                                          if (item["role"]
                                                                  .toString() ==
                                                              "company") {
                                                            return Account(
                                                                id: item['id'],
                                                                firstName: item[
                                                                    "firstName"],
                                                                lastName: item[
                                                                    "lastName"],
                                                                email: item[
                                                                    "email"],
                                                                password: item[
                                                                    "password"],
                                                                phoneNumber: item[
                                                                    "phoneNumber"],
                                                                role: item[
                                                                    "role"],
                                                                image: item[
                                                                    "image_url"]);
                                                          }
                                                        }).toList();
                                                        list = list
                                                            .whereType<
                                                                Account>()
                                                            .toList();
                                                        Provider.of<CompaniesProvider>(
                                                                ctx,
                                                                listen: false)
                                                            .setCompanies(list
                                                                as List<
                                                                    Account>);

                                                        return StreamBuilder<
                                                                QuerySnapshot>(
                                                            stream: FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'categories')
                                                                .snapshots(),
                                                            builder: (ctx,
                                                                categoriesSnapshot) {
                                                              if (categoriesSnapshot
                                                                      .data ==
                                                                  null) {
                                                                return SplashScreen();
                                                              }
                                                              List<CategoriesModel?>
                                                                  list =
                                                                  categoriesSnapshot
                                                                      .data!
                                                                      .docs
                                                                      .map(
                                                                          (item) {
                                                                return CategoriesModel(
                                                                  id: item[
                                                                      'id'],
                                                                  isFood: item[
                                                                      "isFood"],
                                                                  isFragile: item[
                                                                      "isFragile"],
                                                                  isLarge: item[
                                                                      "isLarge"],
                                                                  isMedicine: item[
                                                                      "isMedicine"],
                                                                  isRegular: item[
                                                                      "isRegular"],
                                                                );
                                                              }).toList();
                                                              Provider.of<CompaniesProvider>(
                                                                      ctx,
                                                                      listen:
                                                                          false)
                                                                  .setCategories(
                                                                      list as List<
                                                                          CategoriesModel>);
                                                              return ClientNavigationScreen();
                                                            });
                                                      });
                                                });
                                          } else if (role == 'company') {
                                            return StreamBuilder<
                                                    DocumentSnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('categories')
                                                    .doc(user.uid)
                                                    .snapshots(),
                                                builder:
                                                    (ctx, categoriesSnapshot) {
                                                  if (categoriesSnapshot.data ==
                                                      null) {
                                                    return SplashScreen();
                                                  }
                                                  Map<String, dynamic> data =
                                                      categoriesSnapshot.data
                                                              ?.data()
                                                          as Map<String,
                                                              dynamic>;

                                                  Provider.of<CategoriesProvider>(
                                                          ctx,
                                                          listen: false)
                                                      .setCategories(
                                                          id: data['id'],
                                                          isRegular:
                                                              data['isRegular'],
                                                          isFragile:
                                                              data['isFragile'],
                                                          isLarge:
                                                              data['isLarge'],
                                                          isMedicine: data[
                                                              'isMedicine'],
                                                          isFood:
                                                              data['isFood']);

                                                  return CompanyNavigationScreen();
                                                });
                                          } else
                                            return Container();
                                        });
                                  });
                            });
                      });
                });
          } else {
            return AuthScreen();
          }
        });
  }
}
