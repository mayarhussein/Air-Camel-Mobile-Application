import 'package:air_camel/models/drawer/drawer_list.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/credit/credit_screen.dart';
import 'package:air_camel/pages/company/company_home_dashboard.dart';
import 'package:air_camel/pages/side_drawer_screens/about_us_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/help_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/invite_screen.dart';
import 'package:air_camel/pages/side_drawer_screens/offers_screen.dart';
import 'package:air_camel/widgets/drawer/company_navigation_controller.dart';
import 'package:flutter/material.dart';

class CompanyNavigationScreen extends StatefulWidget {
  @override
  State<CompanyNavigationScreen> createState() =>
      _CompanyNavigationScreenState();
  static const routeName = "/navigation-company";
}

class _CompanyNavigationScreenState extends State<CompanyNavigationScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    // screenView = HomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(children: [
              CompanyNavigationController(
                screenIndex: drawerIndex,
                drawerWidth: MediaQuery.of(context).size.width * 0.75,
                onDrawerCall: (DrawerIndex drawerIndexdata) {
                  changeIndexDrawer(drawerIndexdata);
                  //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
                },
                screenView: CompanyHomeDashboard(),
              ),
            ]),
          ),
        ));
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
