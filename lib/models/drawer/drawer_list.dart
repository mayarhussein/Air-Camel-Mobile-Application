import 'package:flutter/material.dart';

enum DrawerIndex {
  HOME,
  Credit,
  Offers,
  Notifications,
  Help,
  About,
  Invite,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}
