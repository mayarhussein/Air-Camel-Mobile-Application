import 'package:flutter/material.dart';

class CompanyNavigationScreen extends StatefulWidget {
  @override
  State<CompanyNavigationScreen> createState() =>
      _CompanyNavigationScreenState();
  static const routeName = "/navigation-company";
}

class _CompanyNavigationScreenState extends State<CompanyNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Company Screen'),
      ),
    );
  }
}
