import 'package:air_camel/constants.dart';
import 'package:air_camel/providers/accounts_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/categories.dart';
import '../../providers/categories_provider.dart';

enum Category { regular, fragile, medicine, food, large }

class EditCategories extends StatefulWidget {
  static const routeName = '/edit-categories';

  @override
  State<EditCategories> createState() => _EditCategoriesState();
}

class _EditCategoriesState extends State<EditCategories> {
  late String id;
  late bool isRegular;
  late bool isFragile;
  late bool isLarge;
  late bool isMedicine;
  late bool isFood;

  @override
  void initState() {
    CategoriesModel? categories =
        Provider.of<CategoriesProvider>(context, listen: false).categories;
    id = categories!.id;

    isRegular = categories.isRegular;
    isFragile = categories.isFragile;
    isLarge = categories.isLarge;
    isMedicine = categories.isMedicine;
    isFood = categories.isFood;
  }

  Future<void> _save({
    required bool isRegular,
    required bool isFragile,
    required bool isLarge,
    required bool isMedicine,
    required bool isFood,
  }) async {
    final data = FirebaseFirestore.instance.collection('categories');
    await data.doc(id).update({
      'isRegular': isRegular,
      'isFragile': isFragile,
      'isLarge': isLarge,
      'isMedicine': isMedicine,
      'isFood': isFood
    }).then((value) {
      Provider.of<CategoriesProvider>(context, listen: false)
          .EditCategories(isRegular, isFragile, isLarge, isMedicine, isFood);
    }).catchError((error) => print("Failed to update categories: $error"));
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    void Function(bool) updateValue,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: defaultFont1,
      ),
      value: currentValue,
      subtitle: Text(
        description,
      ),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Edit Categories",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () => _save(
                  isFood: isFood,
                  isFragile: isFragile,
                  isLarge: isLarge,
                  isMedicine: isMedicine,
                  isRegular: isRegular),
            ),
          ],
          backgroundColor: bgColor,
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust the company preferences according to the accepted packages:',
                style: headFont1,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildSwitchListTile(
                    'Regular',
                    'Accepts regular packages.',
                    isRegular,
                    (newValue) {
                      setState(
                        () {
                          isRegular = newValue;
                        },
                      );
                    },
                  ),
                  _buildSwitchListTile(
                    'Fragile',
                    'Accepts fragile packages.',
                    isFragile,
                    (newValue) {
                      setState(
                        () {
                          isFragile = newValue;
                        },
                      );
                    },
                  ),
                  _buildSwitchListTile(
                    'Large',
                    'Accepts large packages.',
                    isLarge,
                    (newValue) {
                      setState(
                        () {
                          isLarge = newValue;
                        },
                      );
                    },
                  ),
                  _buildSwitchListTile(
                    'Medicine',
                    'Accepts medicine.',
                    isMedicine,
                    (newValue) {
                      setState(
                        () {
                          isMedicine = newValue;
                        },
                      );
                    },
                  ),
                  _buildSwitchListTile(
                    'Food',
                    'Accepts Food.',
                    isFood,
                    (newValue) {
                      setState(
                        () {
                          isFood = newValue;
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}


//Container(
        //   color: bgColor,
        //   child: Column(
        //     children: <Widget>[
        //       const SizedBox(height: 30,),
        //       Container(
        //          margin: const EdgeInsets.only(left: 20, right: 20) ,
        //          decoration: BoxDecoration(
        //           color: Colors.white, 
        //               border: Border.all( color: Colors.amber, width: 5),
        //                borderRadius: const BorderRadius.all(Radius.circular(20))),     
        //         child: CheckboxListTile(
        //             title:  Text('Regular Package', 
        //                 style: subTitle1 ),
        //               value: Category.regular,
        //               onChanged: (Category? value) {
        //                 setState(() {
        //                   Category.regular = value;
        //                 });
        //               },
        //             ),
        //       ),
        //          const Divider(
        //            thickness: 2,
        //          ), 
        //       Container(
        //         margin: const EdgeInsets.only(left: 20, right: 20) ,
        //         decoration: BoxDecoration(
        //           color: Colors.white, 
        //               border: Border.all(color: Colors.amber, width: 5),
        //                borderRadius: const BorderRadius.all(Radius.circular(20))),     
        //         child: ListTile(
        //             title:  Text('Fragile',
        //                 style: subTitle1),
        //             leading: Radio<Category>(
        //               value: Category.fragile,
        //               groupValue: _category,
        //               onChanged: (Category? value) {
        //                 setState(() {
        //                   _category = value;
        //                 });
        //               },
        //             )),
        //       ),
        //           const Divider(
        //            thickness: 2,
        //          ),
        //       Container(
        //        margin: const EdgeInsets.only(left: 20,right: 20) ,
        //         decoration: BoxDecoration(
        //           color: Colors.white, 
        //               border: Border.all(color: Colors.amber, width: 5),
        //                borderRadius: const BorderRadius.all(Radius.circular(20))),     
        //         child: ListTile(
        //             title:  Text('Large',
        //                 style: subTitle1),
        //             leading: Radio<Category>(
        //               value: Category.large,
        //               groupValue: _category,
        //               onChanged: (Category? value) {
        //                 setState(() {
        //                   _category = value;
        //                 });
        //               },
        //             )),
        //       ),
        //           const Divider(
        //            thickness: 2,
        //          ),
        //       Container(
        //          margin: const EdgeInsets.only(left: 20,right: 20) ,
        //         decoration: BoxDecoration(
        //           color: Colors.white, 
        //               border: Border.all(color: Colors.amber, width: 5),
        //                borderRadius: const BorderRadius.all(Radius.circular(20))),     
        //         child: ListTile(
        //             title:  Text('medicine',
        //                 style:subTitle1),
        //             leading: Radio<Category>(
        //               value: Category.medicine,
        //               groupValue: _category,
        //               onChanged: (Category? value) {
        //                 setState(() {
        //                   _category = value;
        //                 });
        //               },
        //             )),
        //       ),
        //           const Divider(
        //            thickness: 2,
        //          ),
        //       Container(
        //         margin: const EdgeInsets.only(left: 20, right: 20),
        //         decoration: BoxDecoration(
        //           color: Colors.white, 
        //               border: Border.all(color: Colors.amber, width: 5),
        //                borderRadius: const BorderRadius.all(Radius.circular(20))),     
        //         child: ListTile(
        //             title:
        //                  Text('Food', 
        //                 style: subTitle1),
        //             leading: Radio<Category>(
        //               value: Category.food,
        //               groupValue: _category,
        //               onChanged: (Category? value) {
        //                 setState(() {
        //                   _category = value;
        //                 });
        //               },
        //             )),
        //       ),
        //     ],
        //   ),
        //)