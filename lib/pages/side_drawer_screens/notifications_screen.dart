import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      body: Container(),
    );
  }
}
