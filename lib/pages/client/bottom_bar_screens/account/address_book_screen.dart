import 'package:air_camel/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class AddressBook extends StatefulWidget {
  @override
  State<AddressBook> createState() => _AddressBookState();
  static const routeName = '/address_book';
}

class _AddressBookState extends State<AddressBook> {
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final buildingController = TextEditingController();
  final floorController = TextEditingController();
  final aptController = TextEditingController();
  final otherController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _cityFocusNode = FocusNode();
  final _streetFocusNode = FocusNode();
  final _buildingFocusNode = FocusNode();
  final _floorFocusNode = FocusNode();
  final _aptFocusNode = FocusNode();
  final _otherFocusNode = FocusNode();

  Future<void> AddAddress(String city, String street, String building,
      String floor, String apt, String other) async {
    FocusScope.of(context).unfocus();

    final user = FirebaseAuth.instance.currentUser!;
    final userData = FirebaseFirestore.instance.collection('users');
  }

  //   await userData.doc(user.uid).update({
  //     'firstName': firstName,
  //     'lastName': lastName,
  //   }).then((value) {
  //     print("User Updated");
  //     Provider.of<AccountsProvider>(context, listen: false)
  //         .editName(firstName, lastName);
  //     Navigator.pop(context);
  //   }).catchError((error) => print("Failed to update user: $error"));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Address Book",
          style: headFont1,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: bgColor,
        elevation: 0,
        shadowColor: Colors.white,
        actions: [IconButton(onPressed: showMenu, icon: Icon(Icons.add))],
      ),
      body: Container(),
    );
  }

  showMenu() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
                padding: mainPadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        "New Address",
                        style: headFont1,
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: <
                                Widget>[
                          TextFormField(
                            key: const ValueKey('City'),
                            decoration:
                                const InputDecoration(labelText: "City *"),
                            focusNode: _cityFocusNode,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter city';
                              } else if (!isAlpha(value)) {
                                return 'Only Letters Please';
                              }
                              return null;
                            },
                            controller: cityController,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_streetFocusNode);
                            },
                          ),
                          TextFormField(
                            key: const ValueKey('Street'),
                            decoration:
                                const InputDecoration(labelText: "Street *"),
                            focusNode: _streetFocusNode,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter street';
                              }
                              return null;
                            },
                            controller: streetController,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_buildingFocusNode);
                            },
                          ),
                          TextFormField(
                            key: const ValueKey('Building'),
                            decoration:
                                const InputDecoration(labelText: "Building *"),
                            focusNode: _buildingFocusNode,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter building';
                              }
                              return null;
                            },
                            controller: buildingController,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_floorFocusNode);
                            },
                          ),
                          Row(children: <Widget>[
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: TextFormField(
                                  key: const ValueKey('Floor'),
                                  decoration:
                                      const InputDecoration(labelText: "Floor"),
                                  focusNode: _floorFocusNode,
                                  controller: floorController,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_aptFocusNode);
                                  },
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: TextFormField(
                                key: const ValueKey('Apartment'),
                                decoration: const InputDecoration(
                                    labelText: "Apartment"),
                                focusNode: _aptFocusNode,
                                controller: aptController,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_otherFocusNode);
                                },
                              ),
                            )
                          ]),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            minLines: 2,
                            maxLines: 3,
                            key: const ValueKey('Other'),
                            decoration: const InputDecoration(
                                labelText: "Add any additional description"),
                            focusNode: _otherFocusNode,
                            controller: otherController,
                            onFieldSubmitted: (_) {
                              AddAddress(
                                  cityController.text,
                                  streetController.text,
                                  buildingController.text,
                                  floorController.text,
                                  aptController.text,
                                  otherController.text);
                            },
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Fields marked as * are REQUIRED",
                                  style: hintFont,
                                ),
                                Center(
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("Add Address")),
                                ),
                              ],
                            ),
                          )
                        ])),
                  ],
                )),
          );
        });
  }
}
