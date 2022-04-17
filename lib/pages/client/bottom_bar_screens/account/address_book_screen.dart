import 'package:air_camel/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/address.dart';
import '../../../../providers/address_provider.dart';
import '../../../../widgets/address_item.dart';
import '../../../launch_app/splash_screen.dart';

class AddressBook extends StatefulWidget {
  AddressBook({Key? key}) : super(key: key);

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
      'description': other
    }).then((value) {
      cityController.clear();
      streetController.clear();
      buildingController.clear();
      floorController.clear();
      aptController.clear();
      otherController.clear();

      Navigator.pop(context);
      print("success");
    }).catchError((error) => print("Failed to add address: $error"));
  }

  Future<void> _deleteAddress(String userId, String docId) async {
    final addressData = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('address');

    await addressData
        .doc(docId)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    CollectionReference addressData = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('address');
    return ChangeNotifierProvider(
        create: (_) => AddressProvider(),
        child: StreamBuilder<QuerySnapshot>(
            stream: addressData.snapshots(),
            builder: (ctx, addressSanpshot) {
              if (addressSanpshot.data == null) {
                return SplashScreen();
              }
              List<AddressModel> addressList =
                  addressSanpshot.data!.docs.map((item) {
                Timestamp stamp = item['dateTime'];
                return AddressModel(
                    id: item['id'],
                    idAccount: item['idAccount'],
                    dateTime: DateTime.parse(stamp.toDate().toString()),
                    city: item['city'],
                    street: item['street'],
                    building: item['building'],
                    floor: item['floor'],
                    apt: item['apt'],
                    other: item['description']);
              }).toList();
              Provider.of<AddressProvider>(ctx).setAddress(addressList);
              final addressData = Provider.of<AddressProvider>(ctx);

              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    "Address Book",
                    style: headFont1,
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  backgroundColor: bgColor,
                  elevation: 0,
                  shadowColor: Colors.white,
                  actions: [
                    IconButton(onPressed: showMenu, icon: const Icon(Icons.add))
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                      itemCount: addressData.address.length,
                      itemBuilder: (context, i) {
                        return Slidable(
                          child: AddressItem(
                              showMenu,
                              addressData.address[i].city,
                              addressData.address[i].street,
                              addressData.address[i].building,
                              addressData.address[i].floor,
                              addressData.address[i].apt),
                          //key: const ValueKey(0),
                          endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    _deleteAddress(
                                        user.uid, addressData.address[i].id);
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ]),
                        );
                      }),
                ),
              );
            }));
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
                    SingleChildScrollView(
                      child: Card(
                        child: SingleChildScrollView(
                          child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TextFormField(
                                    key: const ValueKey('City'),
                                    decoration: const InputDecoration(
                                        labelText: "City *"),
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
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
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
                                        child: const Text('Add Address',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        onPressed: () {
                                          _AddAddress(
                                              cityController.text.trim(),
                                              streetController.text.trim(),
                                              buildingController.text.trim(),
                                              floorController.text.trim(),
                                              aptController.text.trim(),
                                              otherController.text.trim());
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
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}
