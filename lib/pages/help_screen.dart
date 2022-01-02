import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
    static const routeName = '/help';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
      alignment: Alignment.center,
      child: Text("Here is help screen!!!!"),
    ));
  }
}
