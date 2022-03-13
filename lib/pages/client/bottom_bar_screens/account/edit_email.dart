import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:air_camel/providers/client_data.dart';
import 'package:air_camel/widgets/appbar_widget.dart';
import 'package:email_validator/email_validator.dart';

// This class handles the Page to edit the Email Section of the User Profile.
class EditEmailScreen extends StatefulWidget {
  const EditEmailScreen({Key? key}) : super(key: key);

  @override
  EditEmailScreenState createState() {
    return EditEmailScreenState();
  }
}

class EditEmailScreenState extends State<EditEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  var client = ClientData.myClient;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> updateUserValue(String email) async {
    FocusScope.of(context).unfocus();

    final user = FirebaseAuth.instance.currentUser!;

  

    await user.updateEmail(email);

    final userData = FirebaseFirestore.instance.collection('users');

    await userData
        .doc(user.uid)
        .update({
          'email': email,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                    width: 320,
                    child: const Text(
                      "What's your email?",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: SizedBox(
                        height: 100,
                        width: 320,
                        child: TextFormField(
                          // Handles Form Validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Your email address'),
                          controller: emailController,
                        ))),
                Padding(
                    padding: EdgeInsets.only(top: 150),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 320,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate() &&
                                  EmailValidator.validate(
                                      emailController.text)) {
                                updateUserValue(emailController.text);
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.amber,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            child: const Text(
                              'Update',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        )))
              ]),
        ));
  }
}
