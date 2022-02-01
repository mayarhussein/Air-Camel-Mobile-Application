import 'package:air_camel/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

enum Category { regular, fragile, medecine, food, large }

class EditCategories extends StatefulWidget {
  static const routeName = '/edit-categories';

  @override
  State<EditCategories> createState() => _EditCategoriesState();
}

class _EditCategoriesState extends State<EditCategories> {
  Category? _category = Category.regular;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Categories",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: bgColor,
        ),
        body: Container(
          color: bgColor,
          child: Column(
            children: <Widget>[
              ListTile(
                  title: const Text('Regular Package',
                      style: TextStyle(color: Colors.black)),
                  leading: Radio<Category>(
                    value: Category.regular,
                    groupValue: _category,
                    onChanged: (Category? value) {
                      setState(() {
                        _category = value;
                      });
                    },
                  )),
              ListTile(
                  title: const Text('Fragile',
                      style: TextStyle(color: Colors.black)),
                  leading: Radio<Category>(
                    value: Category.fragile,
                    groupValue: _category,
                    onChanged: (Category? value) {
                      setState(() {
                        _category = value;
                      });
                    },
                  )),
              ListTile(
                  title: const Text('Large',
                      style: TextStyle(color: Colors.black)),
                  leading: Radio<Category>(
                    value: Category.large,
                    groupValue: _category,
                    onChanged: (Category? value) {
                      setState(() {
                        _category = value;
                      });
                    },
                  )),
              ListTile(
                  title: const Text('Medecine',
                      style: TextStyle(color: Colors.black)),
                  leading: Radio<Category>(
                    value: Category.medecine,
                    groupValue: _category,
                    onChanged: (Category? value) {
                      setState(() {
                        _category = value;
                      });
                    },
                  )),
              ListTile(
                  title:
                      const Text('Food', style: TextStyle(color: Colors.black)),
                  leading: Radio<Category>(
                    value: Category.food,
                    groupValue: _category,
                    onChanged: (Category? value) {
                      setState(() {
                        _category = value;
                      });
                    },
                  )),
            ],
          ),
        ));
  }
}
