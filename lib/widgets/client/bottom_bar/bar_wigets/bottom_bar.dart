import 'package:air_camel/models/bottom_navigation/bottom_bar_model.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/new_shipment/new_shipment_menu_screen.dart';
import 'package:air_camel/widgets/client/bottom_bar/bar_wigets/bottom_bar_view.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final Function(int)? onBottomBarCall;

  BottomBar(this.onBottomBarCall);

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
            changeIndex: onBottomBarCall),
      ],
    );
  }
}
