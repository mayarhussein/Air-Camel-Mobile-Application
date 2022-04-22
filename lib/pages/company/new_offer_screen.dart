import 'package:air_camel/constants.dart';
import 'package:air_camel/widgets/company/shipments_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../providers/offers_provider.dart';

class NewOfferScreen extends StatefulWidget {
  static const routeName = '/new-offer';

  @override
  State<NewOfferScreen> createState() => _NewOfferScreenState();
}

class _NewOfferScreenState extends State<NewOfferScreen> {
  final _formKey = GlobalKey<FormState>();
  String date = "";
  DateTime selectedDate = DateTime.now();
  final descriptionController = TextEditingController();

  Future<void> _submit(String description) async {
    final user = FirebaseAuth.instance.currentUser!;
    final offersData = FirebaseFirestore.instance.collection('offers');
    var randomId = const Uuid().v4();

    await offersData.doc(randomId).set({
      'id': randomId,
      'dateTime': DateTime.now(),
      'expireTime': selectedDate,
      'idCompany': user.uid,
      'offerMsg': description,
    }).then((value) {
      print("Success");
      descriptionController.clear();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: const Text('offer added'),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }).catchError((error) => print("Failed : $error"));
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "New Offer",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: bgColor,
        ),
        body: SingleChildScrollView(
            child: Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Form(
                            key: _formKey,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      ElevatedButton(
                                        onPressed: () {
                                          _selectDate(context);
                                        },
                                        child: const Text("Pick Expire Date"),
                                      ),
                                      const Icon(Icons.date_range),
                                      Text(
                                          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                                    ],
                                  ),
                                  TextFormField(
                                    key: const ValueKey('Description'),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                        labelText: 'Description'),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the offer description';
                                      }
                                      return null;
                                    },
                                    controller: descriptionController,
                                    onFieldSubmitted: (_) {
                                      if (_formKey.currentState!.validate()) {
                                        _submit(descriptionController.text);
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                      child: const Text('Submit',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _submit(descriptionController.text);
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
                                ])))))));
  }
}
