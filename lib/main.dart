import 'dart:io';
import 'package:air_camel/pages/home/filters_screen.dart';
import 'package:air_camel/pages/home/new_shipment_menu_screen.dart';
import 'package:air_camel/pages/home/navigation_screen.dart';
import 'package:air_camel/resources/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
    return MaterialApp(
      title: 'GoCaamel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber.shade600,
        textTheme: AppTheme.textTheme,
        // platform: TargetPlatform.iOS,
      ),
      // home: NavigationHomeScreen(),
      home: NavigationHomeScreen(),
      routes: {
        FiltersScreen.routeName: (ctx) => FiltersScreen(),
        NavigationHomeScreen.routeName: (ctx) => NavigationHomeScreen(),
        NewShipmentMenu.routeName: (ctx) => NewShipmentMenu(),
      },
    );
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
