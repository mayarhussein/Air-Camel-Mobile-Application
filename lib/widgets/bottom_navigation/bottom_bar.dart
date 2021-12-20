import 'package:air_camel/models/bottom_navigation/bottom_bar_model.dart';
import 'package:air_camel/models/drawer/drawer_list.dart';
import 'package:air_camel/pages/home/new_shipment_menu_screen.dart';
import 'package:air_camel/widgets/bottom_navigation/bottom_bar_view.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            FocusScope.of(context).requestFocus(FocusNode());
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => NewShipmentMenu(),
                  fullscreenDialog: true),
            );
          },
          changeIndex: (int index) {
            print(index);
            // if (index == 0 || index == 2) {
            //   // animationController?.reverse().then<dynamic>((data) {
            //     if (!mounted) {
            //       return;
            //     }
            //     setState(() {
            //       // tabBody =
            //       //     MyDiaryScreen(animationController: animationController);
            //     });
            //   });
            // } else if (index == 1 || index == 3) {
            //   animationController?.reverse().then<dynamic>((data) {
            //     if (!mounted) {
            //       return;
            //     }
            //     setState(() {
            //       // tabBody =
            //       //     TrainingScreen(animationController: animationController);
            //     });
            //   });
            // }
          },
        ),
      ],
    );
  }
}
