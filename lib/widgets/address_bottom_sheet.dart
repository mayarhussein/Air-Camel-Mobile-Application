import 'package:air_camel/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:uuid/uuid.dart';

import '../models/address.dart';
import '../providers/address_provider.dart';

class AddressBottomSheet {
  static void showAddressBottomSheet(context, bool isEdit, String Addressid) {
    var cityController = TextEditingController();
    var streetController = TextEditingController();
    var buildingController = TextEditingController();
    var floorController = TextEditingController();
    var aptController = TextEditingController();
    var otherController = TextEditingController();

    if (isEdit) {
      List<AddressModel> addressList =
          Provider.of<AddressProvider>(context, listen: false).address;
      final theAddress = addressList.firstWhere((item) => item.id == Addressid);

      cityController.text = theAddress.city;
      streetController.text = theAddress.street;
      buildingController.text = theAddress.building;
      floorController.text = theAddress.floor;
      aptController.text = theAddress.apt;
      otherController.text = theAddress.other.toString();
    }

    final _formKey = GlobalKey<FormState>();
    final _cityFocusNode = FocusNode();
    final _streetFocusNode = FocusNode();
    final _buildingFocusNode = FocusNode();
    final _floorFocusNode = FocusNode();
    final _aptFocusNode = FocusNode();
    final _otherFocusNode = FocusNode();

    void clearTexts() {
      cityController.clear();
      streetController.clear();
      buildingController.clear();
      floorController.clear();
      aptController.clear();
      otherController.clear();
    }

    // void disposeNodes() {
    //   _cityFocusNode.dispose();
    //   _streetFocusNode.dispose();
    //   _buildingFocusNode.dispose();
    //   _floorFocusNode.dispose();
    //   _aptFocusNode.dispose();
    //   _otherFocusNode.dispose();
    // }

    Future<void> _AddAddress(String city, String street, String building,
        String floor, String apt, String other) async {
      FocusScope.of(context).unfocus();

      final user = FirebaseAuth.instance.currentUser!;
      final addressData = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('address');
      var randomId = const Uuid().v4();

      await addressData.doc(randomId).set({
        'id': randomId,
        'idAccount': user.uid,
        'dateTime': DateTime.now(),
        'city': city,
        'street': street,
        'building': building,
        'floor': floor,
        'apt': apt,
        'other': other
      }).then((value) {
        // TO CHECK STH HERE: Provider Fn
        clearTexts();
        Navigator.pop(context);
        print("Add success");
      }).catchError((error) => print("Failed to add address: $error"));
    }

    void _editAddress(String city, String street, String building, String floor,
        String apt, String other) async {
      FocusScope.of(context).unfocus();

      final user = FirebaseAuth.instance.currentUser!;
      final addressData = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('address');

      await addressData.doc(Addressid).update({
        'city': city,
        'street': street,
        'building': building,
        'floor': floor,
        'apt': apt,
        'other': other
      }).then((value) {
        // TO CHECK STH HERE: Provider Fn
        clearTexts();

        Navigator.pop(context);
        print("Address Updated");
      }).catchError((error) => print("Failed to update user: $error"));
    }

    Size size = MediaQuery.of(context).size;

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
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          isEdit ? 'Edit Address' : "New Address",
                          style: headFont1,
                        ),
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextFormField(
                                key: const ValueKey('City'),
                                decoration:
                                    const InputDecoration(labelText: "City *"),
                                focusNode: _cityFocusNode,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter city';
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
                                decoration: const InputDecoration(
                                    labelText: "Street *"),
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
                                decoration: const InputDecoration(
                                    labelText: "Building *"),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: TextFormField(
                                      key: const ValueKey('Floor'),
                                      decoration: const InputDecoration(
                                          labelText: "Floor"),
                                      focusNode: _floorFocusNode,
                                      controller: floorController,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(_aptFocusNode);
                                      },
                                    )),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
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
                                minLines: 1,
                                key: const ValueKey('Other'),
                                decoration: const InputDecoration(
                                    labelText:
                                        "Add any additional description"),
                                focusNode: _otherFocusNode,
                                controller: otherController,
                                onFieldSubmitted: (_) {
                                  if (_formKey.currentState!.validate()) {
                                    _AddAddress(
                                        cityController.text.trim(),
                                        streetController.text.trim(),
                                        buildingController.text.trim(),
                                        floorController.text.trim(),
                                        aptController.text.trim(),
                                        otherController.text.trim());
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Fields marked as * are REQUIRED",
                                  style: hintFont),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: ElevatedButton(
                                    child: Text(
                                        isEdit ? 'Edit Address' : 'Add Address',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    onPressed: () {
                                      if (isEdit) {
                                        if (_formKey.currentState!.validate()) {
                                          _editAddress(
                                              cityController.text.trim(),
                                              streetController.text.trim(),
                                              buildingController.text.trim(),
                                              floorController.text.trim(),
                                              aptController.text.trim(),
                                              otherController.text.trim());
                                        }
                                      } else {
                                        if (_formKey.currentState!.validate()) {
                                          _AddAddress(
                                              cityController.text.trim(),
                                              streetController.text.trim(),
                                              buildingController.text.trim(),
                                              floorController.text.trim(),
                                              aptController.text.trim(),
                                              otherController.text.trim());
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                            width: 3, color: Colors.amber),
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        padding: const EdgeInsets.all(
                                            20) //content padding inside button
                                        )),
                              )
                            ],
                          )),
                    ],
                  ),
                )),
          );
        });
  }
}
