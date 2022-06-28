// @dart=2.9
// ignore_for_file: missing_return

import 'dart:io';
import 'package:air_camel/constants.dart';
import 'package:air_camel/main_controller.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/account/address_book_screen.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/credit/credit_screen.dart';
import 'package:air_camel/pages/company/new_offer_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/chat_bot_screen.dart';
import 'package:air_camel/providers/address_provider.dart';
import 'package:air_camel/providers/categories_provider.dart';
import 'package:air_camel/providers/companies_provider.dart';
import 'package:air_camel/providers/credit_payments_provider.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/account/edit_profile.dart';
import 'package:air_camel/pages/company/company_navigation_home_screen.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/new_shipment/filters_screen.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/new_shipment/new_shipment_menu_screen.dart';
import 'package:air_camel/pages/client/client_navigation_screen.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/new_shipment/place_shipment_screen.dart';
import 'package:air_camel/pages/company/company_complaints_screen.dart';
import 'package:air_camel/pages/company/edit_categories.dart';
import 'package:air_camel/pages/company/payment_history.dart';
import 'package:air_camel/pages/side_drawer_screens/about_us_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/help_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/invite_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/offers_screen.dart';
import 'package:air_camel/providers/notifications_provider.dart';
import 'package:air_camel/providers/offers_provider.dart';
import 'package:air_camel/providers/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:air_camel/providers/accounts_provider.dart';
import 'package:firebase_core/firebase_core.dart';

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
          ChangeNotifierProvider(create: (ctx) => OrdersProvider()),
          ChangeNotifierProvider(create: (ctx) => AccountsProvider()),
          ChangeNotifierProvider(create: (ctx) => NotificationsProvider()),
          ChangeNotifierProvider(create: (ctx) => CreditPaymentsProvider()),
          ChangeNotifierProvider(create: (ctx) => CategoriesProvider()),
          ChangeNotifierProvider(create: (ctx) => CompaniesProvider()),
          ChangeNotifierProvider(create: (ctx) => AddressProvider()),
          ChangeNotifierProvider(create: (ctx) => OffersProvider()),
        ],
        child: MaterialApp(
          title: 'AirCamel',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: bgColor,
            primarySwatch: Colors.amber,
          ),
          home: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: MainController()),
          routes: {
            FiltersScreen.routeName: (ctx) => FiltersScreen(),
            ClientNavigationScreen.routeName: (ctx) => ClientNavigationScreen(),
            NewShipmentMenu.routeName: (ctx) => NewShipmentMenu(),
            PlaceShipmentScreen.routeName: (ctx) => PlaceShipmentScreen(),
            CompanyNavigationScreen.routeName: (ctx) =>
                CompanyNavigationScreen(),
            HelpScreen.routeName: (ctx) => HelpScreen(),
            AboutUsScreen.routeName: (ctx) => AboutUsScreen(),
            OffersScreen.routeName: (ctx) => OffersScreen(),
            InviteScreen.routeName: (ctx) => InviteScreen(),
            EditCategories.routeName: (ctx) => EditCategories(),
            CompanyComplaintsScreen.routeName: (ctx) =>
                CompanyComplaintsScreen(),
            PayementsHistory.routeName: (ctx) => PayementsHistory(),
            EditProfileScreen.routeName: (ctx) => EditProfileScreen(),
            NewOfferScreen.routeName: (ctx) => NewOfferScreen(),
            AddressBook.routeName: (ctx) => AddressBook(),
            ChatBotScreen.routeName: (ctx) => ChatBotScreen(),
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
