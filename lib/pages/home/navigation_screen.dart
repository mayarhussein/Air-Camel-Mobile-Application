import 'package:air_camel/providers/accounts_provider.dart';
import 'package:air_camel/models/drawer/drawer_list.dart';
import 'package:air_camel/pages/account/account_screen.dart';
import 'package:air_camel/pages/home/home_screen.dart';
import 'package:air_camel/pages/home/new_shipment_menu_screen.dart';
import 'package:air_camel/resources/app_theme.dart';
import 'package:air_camel/widgets/bottom_navigation/bottom_bar.dart';
import 'package:air_camel/widgets/drawer/navigation_controller.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../help_screen.dart';
import '../my_trips_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();

  static const routeName = "/navigation-home";
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = HomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // LISTENER : Listening to any change in Accounts Provider
    final accountsData = Provider.of<AccountsProvider>(context);

    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: Stack(children: [
            NavigationController(
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
              //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
            ),
            // BottomBar(),
          ]),
        ),
      ),
    );
  }

  void changeIndexBottomBar(int index) {
    switch (index) {
      case 0:
        setState(() {
          screenView = HomeScreen();
        });
        break;
      case 1:
        setState(() {
          screenView = MyTripsScreen();
        });
        print("Blahblah");
        break;
      case 2:
        setState(() {
          screenView = HelpScreen();
        });
        print("Settings");
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
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = HomeScreen();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = AccountScreen();
        });
      } else if (drawerIndex == DrawerIndex.FeedBack) {
        setState(() {
          // screenView = FeedbackScreen();
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          // screenView = InviteFriend();
        });
      } else {
        //do in your way......
      }
    }
  }
}
