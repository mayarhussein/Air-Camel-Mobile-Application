import 'dart:math';

import 'package:air_camel/pages/account/signup_screen.dart';
import 'package:air_camel/pages/home/navigation_screen.dart';
import 'package:air_camel/widgets/my_button.dart';
import 'package:flutter/material.dart';

import 'account/login_screen.dart';
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
      body:Container(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned.fill(
                 child: Image.asset('assets/images/gold.jpg',fit: BoxFit.cover)
                 ),
            Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //1
                Center(
                  child: ClipOval(
                    child: Container(
                      width: 180,
                      height: 180,
                      color: Colors.grey,
                      alignment: Alignment.center,
                      child: const Text('Logo',
                         style: TextStyle(
                           fontSize: 50,
                           color: Colors.white,
                           fontFamily: 'Roboto-Bold'
                            )))),
                ),
                //2
               const SizedBox(height: 30),
               //3
               const Text('Air Camel',
                   textAlign: TextAlign.center,
                   style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'WorkSans-SemiBold')),
               //4       
               const SizedBox(height: 30),
               //5
               Text('dgdfgfgfhfghgh fgfhdfhf',
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     color: Colors.white.withOpacity(0.5),
                      fontSize: 18,
                      fontFamily: 'WorkSans-SemiBold',
                      )),
               //6
                MyButton('LOGIN', LoginScreen.routeName,_role),
                //7 
                 MyButton('SIGNUP', SignupScreen.routeName,_role),
                 //MyButton('guest', NavigationHomeScreen.routeName),
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
          title: const Text('Companyt'),
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
                    
                   
                 
               
                
              ],) )     
            ],
        ), 
        
        
      
    ));
  }
}


