import 'package:air_camel/models/categories.dart';
import 'package:air_camel/models/drawer/credit_transactions.dart';
import 'package:air_camel/models/drawer/payments.dart';
import 'package:air_camel/models/notification.dart';
import 'package:air_camel/pages/client/client_navigation_screen.dart';
import 'package:air_camel/pages/company/company_navigation_home_screen.dart';
import 'package:air_camel/pages/company/edit_categories.dart';
import 'package:air_camel/pages/launch_app/auth_screen.dart';
import 'package:air_camel/pages/launch_app/splash_screen.dart';
import 'package:air_camel/providers/accounts_provider.dart';
import 'package:air_camel/providers/credit_payments_provider.dart';
import 'package:air_camel/providers/notifications_provider.dart';
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
            final user = FirebaseAuth.instance.currentUser;
            CollectionReference usersData =FirebaseFirestore.instance.collection('users');
            return StreamBuilder<DocumentSnapshot>(
                stream: usersData.doc(user!.uid).snapshots(),
                builder: (ctx, usersSnapshot) {
                  if (usersSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return SplashScreen();
                  }
                  Map<String, dynamic> data =
                      usersSnapshot.data!.data() as Map<String, dynamic>;
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
                  return StreamBuilder(
                    stream:  usersData
                            .doc(user.uid)
                            .collection('address')
                            .snapshots(),
                    builder:(ctx, addressSnapshot){
                         if (addressSnapshot.data == null) {
                            return SplashScreen();
                          }
                        






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
                                return StreamBuilder<QuerySnapshot>(
                                    stream: usersData
                                        .doc(user.uid)
                                        .collection('credit_transactions')
                                        .snapshots(),
                                    builder: (ctx, creditTransactionsSnapshot) {
                                      if (creditTransactionsSnapshot.data ==
                                          null) {
                                        return SplashScreen();
                                      }
                                      List<CreditTransactionsModel>
                                          creditTransactionsList =
                                          creditTransactionsSnapshot.data!.docs
                                              .map((item) {
                                        Timestamp stamp = item['dateTime'];
                                        return CreditTransactionsModel(
                                            amount: double.parse(
                                                item["amount"].toString()),
                                            dateTime: DateTime.parse(
                                                stamp.toDate().toString()),
                                            reason: item['reason']);
                                      }).toList();
                                      Provider.of<CreditPaymentsProvider>(ctx)
                                          .setCreditTransactions(
                                              creditTransactionsList);
                                      //------------------------------------------------------------------
                                      if (role == 'client') {
                                        return ClientNavigationScreen();
                                      } else if (role == 'company') {
                                        return StreamBuilder<QuerySnapshot>(
                                            stream: usersData
                                                .doc(user.uid)
                                                .collection('categories')
                                                .snapshots(),
                                            builder: (ctx, categoriesSnapshot) {
                                              if (categoriesSnapshot.data ==
                                                  null) {
                                                return SplashScreen();
                                              }
                                              List<CategoriesModel> data =
                                                  categoriesSnapshot.data!.docs
                                                      .map((item) {
                                                return CategoriesModel(
                                                    isRegular: item["isRegular"],
                                                    isFragile: item["isFragile"],
                                                    isLarge: item["isLarge"],
                                                    isMedecine:
                                                        item["isMedecine"],
                                                    isFood: item["isFood"]);
                                              }).toList();
                  
                                              print(data.first.isRegular
                                                      .toString() +
                                                  " 1111");
                                              print(data.first.isRegular
                                                      .toString() +
                                                  " 22222");
                                              Provider.of<CategoriesProvider>(ctx,
                                                      listen: false)
                                                  .setCategories(
                                                      isRegular:
                                                          data.first.isRegular,
                                                      isFragile:
                                                          data.first.isFragile,
                                                      isLarge: data.first.isLarge,
                                                      isMedecine:
                                                          data.first.isMedecine,
                                                      isFood: data.first.isFood);
                  
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
