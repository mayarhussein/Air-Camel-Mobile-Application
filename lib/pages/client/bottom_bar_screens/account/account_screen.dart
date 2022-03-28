import 'dart:async';
import 'package:air_camel/constants.dart';
import 'package:air_camel/models/account.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/account/edit_profile.dart';
import 'package:air_camel/providers/accounts_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = '/account';
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    Account? account = Provider.of<AccountsProvider>(context).account;
    String firstName = account!.firstName;
    String lastName = account.lastName;
    String email = account.email;
    String phoneNumber = account.phoneNumber;
    String image = account.image;

    return Container(
      width: double.infinity,
      padding: mainPadding,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.12,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text("Profile", style: headFont1),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.08),
              child: Row(
                children: [
                  Flexible(
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.1,
                      backgroundColor: Colors.transparent,
                      child: Image.network(image.toString()),
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
                          'Name : ' + firstName + ' ' + lastName,
                          style: defaultFont1,
                          textAlign: TextAlign.left,
                        )),
                        Container(
                          child: Text(
                            "Email : " + email,
                            style: defaultFont1,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          child: Text(
                            "Phone : " + phoneNumber,
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
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.of(context)
                          .pushNamed(EditProfileScreen.routeName),
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
                                const Image(
                                  image: AssetImage("assets/images/profile.png"),
                                  fit: BoxFit.scaleDown,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: InkWell(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "History",
                                      style: headFontBig1,
                                    ),
                                    const Image(
                                      image:
                                          AssetImage("assets/images/history.png"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Settings",
                                      style: headFontBig1,
                                    ),
                                    const Image(
                                      image: AssetImage(
                                          "assets/images/settings.png"),
                                    ),
                                  ],
                                ),
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
      ),
    );
  }
}
