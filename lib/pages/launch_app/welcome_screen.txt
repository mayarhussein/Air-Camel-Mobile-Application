import 'dart:math';

import 'package:air_camel/pages/company/company_navigation_home_screen.dart';
import 'package:air_camel/pages/client/client_navigation_screen.dart';
import 'package:air_camel/pages/launch_app/login_screen.dart';
import 'package:air_camel/pages/launch_app/signup_screen.dart';
import 'package:air_camel/widgets/my_button.dart';
import 'package:flutter/material.dart';

enum Role { client, company }

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcomepage';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Role? _role = Role.client;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
              child: Image.asset('assets/images/gold.jpg', fit: BoxFit.cover)),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50,
              ),
              //1
              Center(
                child: Container(
                    width: 250,
                    height: 250,
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.fill,
                    )),
              ),
              //2

              //6
              MyButton('Login', LoginScreen.routeName, _role),
              //7
              MyButton('Register', SignupScreen.routeName, _role),
              MyButton(
                  'Pass',
                  _role == Role.client
                      ? ClientNavigationScreen.routeName
                      : CompanyNavigationScreen.routeName,
                  _role),
              //8
              Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('Client'),
                    leading: Radio<Role>(
                      value: Role.client,
                      groupValue: _role,
                      onChanged: (Role? value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Company'),
                    leading: Radio<Role>(
                      value: Role.company,
                      groupValue: _role,
                      onChanged: (Role? value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    ));
  }
}
