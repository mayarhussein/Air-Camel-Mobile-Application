// @dart=2.9
// ignore_for_file: missing_return

import 'dart:io';

import 'package:air_camel/models/drawer/credit_transactions.dart';
import 'package:air_camel/models/drawer/payments.dart';
import 'package:air_camel/providers/credit_payments_provider.dart';

import 'package:air_camel/models/notification.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/account/edit_profile.dart';
import 'package:air_camel/pages/company/company_navigation_home_screen.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/new_shipment/filters_screen.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/new_shipment/new_shipment_menu_screen.dart';
import 'package:air_camel/pages/client/client_navigation_screen.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/new_shipment/trip_detail_screen.dart';
import 'package:air_camel/pages/company/complaints_screen.dart';
import 'package:air_camel/pages/company/edit_categories.dart';
import 'package:air_camel/pages/company/payment_history.dart';
import 'package:air_camel/pages/launch_app/auth_screen.dart';
import 'package:air_camel/pages/launch_app/login_screen.txt';
import 'package:air_camel/pages/launch_app/splash_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/about_us_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/credit_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/help_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/invite_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/offers_screen.dart';
import 'package:air_camel/providers/notifications_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:air_camel/providers/accounts_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => AccountsProvider()),
          ChangeNotifierProvider(create: (ctx) => NotificationsProvider()),
          ChangeNotifierProvider(create: (ctx) => CreditPaymentsProvider()),
        ],
        child: MaterialApp(
          title: 'AirCamel',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.amber.shade600,
            primarySwatch: Colors.amber,

            //textTheme: AppTheme.textTheme,
            // textTheme: ThemeData.light().textTheme.copyWith(
            //     bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            //     bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            //     subtitle1: TextStyle(
            //         color: Colors.white,
            //         fontSize: 20,
            //         fontFamily: 'WorkSans-Regular',
            //         fontWeight: FontWeight.bold)),
            // // platform: TargetPlatform.iOS,
          ),

          home: StreamBuilder(
              // Life Listener
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (_, userSanpshot) {
                if (userSanpshot.hasData) {
                  final user = FirebaseAuth.instance.currentUser;
                  CollectionReference usersData =
                      FirebaseFirestore.instance.collection('users');
                  CollectionReference notificationsData =
                      usersData.doc(user.uid).collection('notifications');

                  return StreamBuilder<DocumentSnapshot>(
                      stream: usersData.doc(user.uid).snapshots(),
                      builder: (ctx, usersSnapshot) {
                        if (usersSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SplashScreen();
                        }
                        Map<String, dynamic> data =
                            usersSnapshot.data.data() as Map<String, dynamic>;
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
                                image: data['image'],
                                role: role);
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
                                  notificationsSnapshot.data.docs.map((item) {
                                Timestamp stamp = item['dateTime'];
                                return NotificationModel(
                                    message: item["message"],
                                    subject: item["subject"],
                                    idFrom: item["idFrom"],
                                    idTo: item["idTo"],
                                    dateTime: DateTime.parse(
                                        stamp.toDate().toString()),
                                    isOpen: item["isOpen"]);
                              }).toList();
                              Provider.of<NotificationsProvider>(ctx)
                                  .setNotifications(notificationList);
                              //------------------------------------------------------------------
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
                                        paymentsSnapshot.data.docs.map((item) {
                                      Timestamp stamp = item['dateTime'];
                                      return PaymentModel(
                                          amount: double.parse(
                                              item["amount"].toString()),
                                          dateTime: DateTime.parse(
                                              stamp.toDate().toString()),
                                          idClient: item["idClient"],
                                          idCompany: item["idCompany"],
                                          companyName: item["companyName"]);
                                    }).toList();
                                    Provider.of<CreditPaymentsProvider>(ctx)
                                        .setPayments(paymentsList);
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
                                                  .data.docs
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
                                            return ClientNavigationScreen();
                                          } else if (role == 'company') {
                                            return CompanyNavigationScreen();
                                          }
                                        });
                                  });
                            });
                      });
                }
                return AuthScreen();
              }),
          //home:SplashScreen(3,WelcomeScreen.routeName),
          // home: CompanyNavigationScreen(),
          routes: {
            FiltersScreen.routeName: (ctx) => FiltersScreen(),
            ClientNavigationScreen.routeName: (ctx) => ClientNavigationScreen(),
            NewShipmentMenu.routeName: (ctx) => NewShipmentMenu(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            TripDetailsScreen.routeName: (ctx) => TripDetailsScreen(),
            CompanyNavigationScreen.routeName: (ctx) =>
                CompanyNavigationScreen(),
            HelpScreen.routeName: (ctx) => HelpScreen(),
            AboutUsScreen.routeName: (ctx) => AboutUsScreen(),
            CreditScreen.routeName: (ctx) => CreditScreen(),
            OffersScreen.routeName: (ctx) => OffersScreen(),
            InviteScreen.routeName: (ctx) => InviteScreen(),
            EditCategories.routeName: (ctx) => EditCategories(),
            ComplaintsScreen.routeName: (ctx) => ComplaintsScreen(),
            PayementsHistory.routeName: (ctx) => PayementsHistory(),
            EditProfileScreen.routeName: (ctx) => EditProfileScreen()
          },
        ));
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
