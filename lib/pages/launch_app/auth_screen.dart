import 'dart:io';
import 'package:air_camel/providers/accounts_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/single_child_widget.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
      String email,
      String password,
      String firstName,
      String lastName,
      String phoneNumber,
      Role? role,
      File image,
      bool isLogin,
      BuildContext ctx) async {
    UserCredential authResult;

    void _showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('An Error Occurred!'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    try {
      setState(() {
        _isLoading = true;
      });

      if (isLogin) {
        // Sign in
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        // Sign up
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final theUser = authResult.user!.uid;
        var randomId = const Uuid().v4();
        var randomId2 = const Uuid().v4();

        //Future<String> uploadImage(var image ) async {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref =
            storage // Access the root cloud storage bucket (The main bucket)
                .ref() //  root bucket
                .child("user_image") // Folder
                .child(theUser + '.jpg'); // File

        // Uploading the file
        await ref.putFile(image);
        final image_url = (await ref.getDownloadURL()).toString();

        // Creating a new user
        // Users Collection is created on the fly and 2 fields are created
        await FirebaseFirestore.instance.collection('users').doc(theUser).set({
          'id': theUser,
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
          'role': role.toString().substring(5),
          'image_url': image_url
        });

        // Creating Notifications Collection with welcome notifiation

        await FirebaseFirestore.instance
            .collection('users/$theUser/notifications')
            .doc(randomId)
            .set({
          'id': randomId,
          'message': 'Hello ' + firstName + '! Welcome to AirCamel',
          'subject': 'welcome',
          'idFrom': 'Admin',
          'idTo': theUser,
          'dateTime': DateTime.now(),
          'isOpen': false
        });

        // Creating Categories Collection

        if (role.toString().substring(5) == 'company') {
          await FirebaseFirestore.instance
              .collection('categories')
              .doc(theUser)
              .set({
            'id': theUser,
            'isRegular': false,
            'isFragile': false,
            'isLarge': false,
            'isMedecine': false,
            'isFood': false
          });
        }
      }
    } on PlatformException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);

      Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Text(errorMessage),
          backgroundColor: Theme.of(ctx).errorColor));

      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      const errorMessage = 'Could not authenticate you. Please try again later';

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).primaryColor,
      body: Stack(children: <Widget>[
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
          image: AssetImage("assets/images/gold.jpg"),
          fit: BoxFit.cover,
        ))),
        Center(
            child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                //1
                Center(
                  child: Container(
                      width: 150,
                      height: 150,
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.fill,
                      )),
                ),

                AuthForm(_submitAuthForm, _isLoading)
              ]),
        ))
      ]),
    );
  }
}
