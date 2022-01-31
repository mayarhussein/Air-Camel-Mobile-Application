import 'package:air_camel/pages/side_drawer_screens/about_us_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/credit_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/help_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/invite_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/notifications_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/offers_screen.dart';
import 'package:air_camel/providers/accounts_provider.dart';
import 'package:air_camel/models/drawer/drawer_list.dart';
import 'package:air_camel/pages/account/account_screen.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/client_home_screen.dart';
import 'package:air_camel/widgets/drawer/client_navigation_controller.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../my_trips_screen.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // LISTENER : Listening to any change in Accounts Provider
    final accountsData = Provider.of<AccountsProvider>(context);

    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(children: [
            ClientNavigationController(
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
          ]),
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
          screenView = MyTripsScreen();
        });
        print("Blahblah");
        break;
      case 2:
        setState(() {
          // screenView = HelpScreen();
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
      if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          Navigator.of(context).pushNamed(HelpScreen.routeName);
          drawerIndex = DrawerIndex.HOME;
        });
      } else if (drawerIndex == DrawerIndex.Notifications) {
        setState(() {
          Navigator.of(context).pushNamed(NotificationsScreen.routeName);
          drawerIndex = DrawerIndex.HOME;
        });
      } else if (drawerIndex == DrawerIndex.Credit) {
        setState(() {
          Navigator.of(context).pushNamed(CreditScreen.routeName);
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
