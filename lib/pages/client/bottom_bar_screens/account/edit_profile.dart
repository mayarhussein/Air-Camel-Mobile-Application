import 'dart:async';
import 'dart:io';
import 'package:air_camel/models/account.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/account/edit_email.dart';

import 'package:air_camel/pages/client/bottom_bar_screens/account/edit_name.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/account/edit_password.dart';
import 'package:air_camel/pages/client/bottom_bar_screens/account/edit_phone.dart';
import 'package:air_camel/providers/accounts_provider.dart';
import 'package:air_camel/widgets/display_image_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class EditProfileScreen extends StatefulWidget {
  static const routeName = '/editProfile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Account? account = Provider.of<AccountsProvider>(context).account;

    String firstName = account!.firstName;
    String lastName = account.lastName;
    String email = account.email;
    String phoneNumber = account.phoneNumber;
    String image = account.image;
    String formattedPhoneNumber = "(+" +
        phoneNumber.substring(0, 2) +
        ") " +
        phoneNumber.substring(2, 7) +
        "-" +
        phoneNumber.substring(7, phoneNumber.length);
    // return StreamBuilder<DocumentSnapshot>(
    //     stream: usersData.doc(theUser.uid).snapshots(),
    //     builder: (ctx, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(child: CircularProgressIndicator());
    //       }

    //       Map<String, dynamic> data =
    //           snapshot.data!.data() as Map<String, dynamic>;
    //       String firstName = data['firstName'];
    //       String lastName = data['lastName'];
    //       String email = data['email'];
    //       String phoneNumber = data['phoneNumber'];
    //       String password = data['password'];

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.of(context).pop();
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
              child: DisplayImage(
            imagePath: image,
            onPressed: _pickImage,
          )),
          buildUserInfoDisplay(
              firstName + ' ' + lastName, ' Name', EditNameScreen()),
          buildUserInfoDisplay(email, 'Email', EditEmailScreen()),
          buildUserInfoDisplay('', 'Password', EditPasswordScreen()),
          buildUserInfoDisplay(
              formattedPhoneNumber, 'Phone Number', EditPhoneScreen()),

          //Expanded(
          // child: '',
          //  flex: 4,
          //)
        ],
      ),
    );
  }

  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: const BoxDecoration(
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
                              style: const TextStyle(fontSize: 16, height: 1.4),
                            ))),
                    const Icon(
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

  File? _ImageFile;

  void _pickImage() async {
    final pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _ImageFile = File(pickedImageFile!.path);
    });
    final accountData = Provider.of<AccountsProvider>(context, listen: false);
    String? userId = accountData.account!.id;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage // Access the root cloud storage bucket (The main bucket)
            .ref() //  root bucket
            .child("user_image") // Folder
            .child(userId.toString() + '.jpg'); // File

    // Uploading the file
    await ref.putFile(_ImageFile!);
    final image_url = (await ref.getDownloadURL()).toString();

    await FirebaseFirestore.instance.collection('users').doc(userId).update(
        {'image_url': image_url}).then((_) => accountData.editImage(image_url));
  }
}
