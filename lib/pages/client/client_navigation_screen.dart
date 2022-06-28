import 'package:air_camel/constants.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/account/account_screen.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/credit/credit_screen.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/notification/notification_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/about_us_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/help_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/invite_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/offers_screen.dart';
import 'package:air_camel/providers/accounts_provider.dart';
import 'package:air_camel/models/drawer/drawer_list.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/home/client_home_screen.dart';
import 'package:air_camel/widgets/drawer/client_navigation_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ClientNavigationScreen extends StatefulWidget {
  @override
  _ClientNavigationScreenState createState() => _ClientNavigationScreenState();

  static const routeName = "/navigation-home";
}

class _ClientNavigationScreenState extends State<ClientNavigationScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = ClientHomeScreen();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    });
    super.initState();
  }

  static SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: bgColor,
    // systemNavigationBarIconBrightness: Brightness.light,
    // systemNavigationBarDividerColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);

    // LISTENER : Listening to any change in Accounts Provider
    final accountsData = Provider.of<AccountsProvider>(context);
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ClientNavigationController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndexDrawer(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            onBottomBarCall: (index) {
              changeIndexBottomBar(index);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndexBottomBar(int index) {
    switch (index) {
      case 0:
        setState(() {
          screenView = ClientHomeScreen();
        });
        break;
      case 1:
        setState(() {
          screenView = NotificationScreen();
        });
        break;
      case 2:
        setState(() {
          screenView = CreditScreen();
        });
        break;
      case 3:
        setState(() {
          screenView = AccountScreen();
        });
        break;
      default:
    }
  }

  void changeIndexDrawer(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          Navigator.of(context).pushNamed(HelpScreen.routeName);
          drawerIndex = DrawerIndex.HOME;
        });
      } else if (drawerIndex == DrawerIndex.Offers) {
        setState(() {
          Navigator.of(context).pushNamed(OffersScreen.routeName);
          drawerIndex = DrawerIndex.HOME;
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          Navigator.of(context).pushNamed(InviteScreen.routeName);
          drawerIndex = DrawerIndex.HOME;
        });
      } else if (drawerIndex == DrawerIndex.About) {
        setState(() {
          Navigator.of(context).pushNamed(AboutUsScreen.routeName);
          drawerIndex = DrawerIndex.HOME;
        });
      } else {
        //do in your way......
      }
    }
  }
}
