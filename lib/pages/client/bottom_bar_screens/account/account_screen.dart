import 'dart:async';

import 'package:air_camel/constants.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/account/edit_email.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/account/edit_image.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/account/edit_name.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/account/edit_phone.dart';
import 'package:flutter/material.dart';

import 'package:air_camel/widgets/display_image_widget.dart';

import 'package:air_camel/providers/client_data.dart';
import 'package:air_camel/providers/client.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = '/account';
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: mainPadding,
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.12,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Profile",
                style: headFont1,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
            child: Row(
              children: [
                Flexible(
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 0.1,
                    backgroundColor: Colors.amber,
                  ),
                  // flex: 2,
                ),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                        "Name : ",
                        style: defaultFont1,
                        textAlign: TextAlign.left,
                      )),
                      Container(
                        child: Text(
                          "Email : ",
                          style: defaultFont1,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Phone : ",
                          style: defaultFont1,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
          Container(
            height: 400,
            child: Column(
              children: [
                InkWell(
                  child: Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: double.infinity,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Edit Profile",
                              style: headFontBig1,
                            ),
                            Image(
                              image: AssetImage("assets/images/profile.png"),
                              fit: BoxFit.scaleDown,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Card(
                        elevation: 5,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "History",
                                  style: headFontBig1,
                                ),
                                Image(
                                  image:
                                      AssetImage("assets/images/history.png"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Card(
                        elevation: 5,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Settings",
                                  style: headFontBig1,
                                ),
                                Image(
                                  image:
                                      AssetImage("assets/images/settings.png"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class _AccountScreenState extends State<AccountScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final client = ClientData.myClient;

//     return Scaffold(
//       body: Column(
//         children: [
//           AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             toolbarHeight: 10,
//           ),
//           Center(
//               child: Padding(
//                   padding: EdgeInsets.only(bottom: 20),
//                   child: Text(
//                     'Edit Profile',
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.amber,
//                     ),
//                   ))),
//           InkWell(
//               onTap: () {
//                 navigateSecondPage(EditImagePage());
//               },
//               child: DisplayImage(
//                 imagePath: client.image,
//                 onPressed: () {},
//               )),
//           buildUserInfoDisplay(client.name, 'Name', EditNameFormPage()),
//           buildUserInfoDisplay(client.phone, 'Phone', EditPhoneFormPage()),
//           buildUserInfoDisplay(client.email, 'Email', EditEmailFormPage()),
//         ],
//       ),
//     );
//   }

//   // Widget builds the display item with the proper formatting to display the user's info
//   Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
//       Padding(
//           padding: EdgeInsets.only(bottom: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.grey,
//                 ),
//               ),
//               SizedBox(
//                 height: 1,
//               ),
//               Container(
//                   width: 350,
//                   height: 40,
//                   decoration: BoxDecoration(
//                       border: Border(
//                           bottom: BorderSide(
//                     color: Colors.grey,
//                     width: 1,
//                   ))),
//                   child: Row(children: [
//                     Expanded(
//                         child: TextButton(
//                             onPressed: () {
//                               navigateSecondPage(editPage);
//                             },
//                             child: Text(
//                               getValue,
//                               style: TextStyle(fontSize: 16, height: 1.4),
//                             ))),
//                     Icon(
//                       Icons.keyboard_arrow_right,
//                       color: Colors.grey,
//                       size: 40.0,
//                     )
//                   ]))
//             ],
//           ));

//   // Refrshes the Page after updating user info.
//   FutureOr onGoBack(dynamic value) {
//     setState(() {});
//   }

//   // Handles navigation and prompts refresh.
//   void navigateSecondPage(Widget editForm) {
//     Route route = MaterialPageRoute(builder: (context) => editForm);
//     Navigator.push(context, route).then(onGoBack);
//   }
// }
