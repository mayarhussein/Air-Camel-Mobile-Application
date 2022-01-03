// @dart=2.9
import 'dart:io';
import 'package:air_camel/pages/company/company_navigation_home_screen.dart';
import 'package:air_camel/pages/home/filters_screen.dart';
import 'package:air_camel/pages/home/new_shipment_menu_screen.dart';
import 'package:air_camel/pages/home/client_navigation_screen.dart';
import 'package:air_camel/pages/home/trip_detail_screen.dart';
import 'package:air_camel/pages/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:air_camel/providers/accounts_provider.dart';

import 'pages/account/login_screen.dart';
import 'pages/account/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        ],
        child: MaterialApp(
          title: 'AirCamel',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.amber.shade600,
            primarySwatch: Colors.amber,

            //textTheme: AppTheme.textTheme,
            textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                subtitle1: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'WorkSans-Regular',
                    fontWeight: FontWeight.bold)),
            // platform: TargetPlatform.iOS,
          ),

          // home: ClientNavigationScreen(),
          //home:SplashScreen(3,WelcomeScreen.routeName),
          home: WelcomeScreen(),
          routes: {
            FiltersScreen.routeName: (ctx) => FiltersScreen(),
            ClientNavigationScreen.routeName: (ctx) => ClientNavigationScreen(),
            NewShipmentMenu.routeName: (ctx) => NewShipmentMenu(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            SignupScreen.routeName: (ctx) => SignupScreen(),
            TripDetailsScreen.routeName: (ctx) => TripDetailsScreen(),
            CompanyNavigationScreen.routeName: (ctx) =>
                CompanyNavigationScreen(),
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
