import 'dart:io';

import 'package:air_camel/constants.dart';
import 'package:air_camel/models/account.dart';
import 'package:air_camel/models/address.dart';
import 'package:air_camel/providers/address_provider.dart';
import 'package:air_camel/resources/app_theme.dart';
import 'package:air_camel/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';

class PlaceShipmentScreen extends StatefulWidget {
  static const routeName = '/placeshipment';

  @override
  State<PlaceShipmentScreen> createState() => _PlaceShipmentScreenState();
}

class _PlaceShipmentScreenState extends State<PlaceShipmentScreen> {
  Account? chosenCompany;
  DateTime? shipmentDate;
  File? _packageImageFile;
  List<AddressModel>? myAddresses;
  AddressModel? _pickupAddress;
  AddressModel? _dropAddress;
  int radioBtnvalue = 1;
  final _typeFocusNode = FocusNode();
  final _weightFocusNode = FocusNode();
  final _dimensionsFocusNode = FocusNode();
  var typeController = TextEditingController();
  var weightController = TextEditingController();
  var dimensionsController = TextEditingController();
// Future<void> _AddShipment( AddressModel pickupAddress,AddressModel dropAddress, DateTime date, Image img,
//         String weight, String apt, String other) async {
//       FocusScope.of(context).unfocus();

//       final user = FirebaseAuth.instance.currentUser!;
//       final addressData = FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .collection('address');
//       var randomId = const Uuid().v4();

//       await addressData.doc(randomId).set({
//         'id': randomId,
//         'idAccount': user.uid,
//         'dateTime': DateTime.now(),
//         'city': city,
//         'street': street,
//         'building': building,
//         'floor': floor,
//         'apt': apt,
//         'other': other
//       }).then((value) {
//         // TO CHECK STH HERE: Provider Fn
//         clearTexts();
//         Navigator.pop(context);
//         print("Add success");
//       }).catchError((error) => print("Failed to add address: $error"));
//     }
  @override
  void initState() {
    myAddresses = Provider.of<AddressProvider>(context, listen: false).address;
    super.initState();
  }

  void _pickedImage(File image) {
    _packageImageFile = image;
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    chosenCompany = routeArgs["account"] as Account;
    shipmentDate = routeArgs["date"] as DateTime;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Column(
          children: [
            Text(
              "Place shipment",
              style: headFont1Small,
            ),
            Text(
              chosenCompany!.firstName + " Company",
              style: hintFont,
            )
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: mainPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Image
              Container(
                // width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.38,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(chosenCompany!.image))),
              ),
              const Divider(
                color: Colors.black38,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 15),
                alignment: Alignment.topLeft,
                child: Text(
                  "Shipment date: " +
                      DateFormat.yMMMd().format(shipmentDate!).toString(),
                  style: hintFont,
                ),
              ),
              Text("Package details", style: headFont1Small),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserImagePicker(_pickedImage),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextFormField(
                          key: const ValueKey('Type'),
                          decoration:
                              const InputDecoration(labelText: "Type *"),
                          focusNode: _typeFocusNode,
                          controller: typeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter type';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_dimensionsFocusNode);
                          }),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextFormField(
                          key: const ValueKey('Dimensions'),
                          decoration:
                              const InputDecoration(labelText: "Dimensions"),
                          focusNode: _dimensionsFocusNode,
                          controller: dimensionsController,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_weightFocusNode);
                          }),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextFormField(
                        key: const ValueKey('Weight'),
                        decoration: const InputDecoration(labelText: "Weight"),
                        focusNode: _weightFocusNode,
                        controller: weightController,
                      ),
                    ),
                    const Divider(
                      color: Colors.black38,
                    ),
                    Text("Pickup address", style: headFont1Small),
                    DropdownButtonFormField(
                        hint: Text("Select address *"),
                        value: _pickupAddress,
                        isExpanded: true,
                        items: myAddresses!.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item.building +
                                ", " +
                                item.street +
                                ", " +
                                item.city),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _pickupAddress = value as AddressModel;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            _pickupAddress = value as AddressModel;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Please fill pickup address";
                          } else {
                            return null;
                          }
                        }),
                    const Divider(
                      color: Colors.black38,
                    ),
                    Text("Drop address", style: headFont1Small),
                    DropdownButtonFormField(
                      hint: Text("Select address *"),
                      value: _dropAddress,
                      isExpanded: true,
                      items: myAddresses!.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item.building +
                              ", " +
                              item.street +
                              ", " +
                              item.city),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _dropAddress = value as AddressModel;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          _dropAddress = value as AddressModel;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please fill drop address";
                        } else if (_dropAddress == _pickupAddress) {
                          return "Drop and pickup addresses can't be the same";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const Divider(
                      color: Colors.black38,
                    ),
                    Text("Payment type", style: headFont1Small),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListTile(
                            title: const Text("Cash"),
                            trailing: Radio(
                              value: 1,
                              groupValue: radioBtnvalue,
                              onChanged: (value) {
                                setState(() {
                                  radioBtnvalue = value as int;
                                });
                              },
                              activeColor: Colors.amber,
                            ),
                          ),
                          ListTile(
                            title: const Text("Credit/Debit Card"),
                            trailing: Radio(
                              value: 2,
                              groupValue: radioBtnvalue,
                              onChanged: (value) {
                                setState(() {
                                  radioBtnvalue = value as int;
                                });
                              },
                              activeColor: Colors.amber,
                            ),
                          ),
                          ListTile(
                            title: const Text("Camel Wallet"),
                            trailing: Radio(
                              value: 3,
                              groupValue: radioBtnvalue,
                              onChanged: (value) {
                                setState(() {
                                  radioBtnvalue = value as int;
                                });
                              },
                              activeColor: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.black38,
                    ),
                    Text(
                      "Total price",
                      style: headFont1Small,
                    ),
                    const SizedBox(
                      height: 40,
                      child: Text("400.99"),
                    ),
                    Container(
                        width: double.infinity,
                        child: RoundedButton(
                          splashColor: bgColor,
                          onPressed: () {},
                          title: "Place Shipment",
                          buttonColor: Colors.amber,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
