import 'dart:async';
import 'package:air_camel/pages/client/bottom_bar_screens/account/edit_email.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/account/edit_image.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/account/edit_name.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/account/edit_phone.dart';
import 'package:air_camel/widgets/appbar_widget.dart';
import 'package:air_camel/widgets/display_image_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class EditProfileScreen extends StatefulWidget {
  static const routeName = '/editProfile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {

    final theUser = FirebaseAuth.instance.currentUser!;
    CollectionReference usersData = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: usersData.doc(theUser.uid).get(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          String firstName = data['firstName'];
          String lastName = data['lastName'];
          String email = data['email'];
          String phoneNumber = data['phoneNumber'];
          String password = data['password'];

          return Scaffold(
            appBar: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      //Navigator.pop(context);
                    })),
            body: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  toolbarHeight: 10,
                ),
                const Center(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(64, 105, 225, 1),
                          ),
                        ))),
                InkWell(
                    onTap: () {
                      navigateSecondPage(EditImageScreen());
                    },
                    child: DisplayImage(
                      imagePath: "",
                      onPressed: () {},
                    )),
                buildUserInfoDisplay(firstName +' '+ lastName, ' Name', EditNameScreen()),
                buildUserInfoDisplay(email, 'Email', EditEmailScreen()),
                // buildUserInfoDisplay("", 'Password', EditEmailScreen()),
                buildUserInfoDisplay(phoneNumber, 'Phone Number', EditPhoneScreen()),

                //Expanded(
                // child: '',
                //  flex: 4,
                //)
              ],
            ),
          );
        });
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: TextStyle(fontSize: 16, height: 1.4),
                            ))),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
