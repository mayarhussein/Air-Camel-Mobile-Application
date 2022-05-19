import 'package:air_camel/providers/accounts_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:air_camel/widgets/appbar_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
//import { getAuth, updateEmail } from "firebase/auth";

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
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> updateUserValue(String newEmail, oldEmail, oldPassword) async {
    FocusScope.of(context).unfocus();

// CollectionReference usersData = FirebaseFirestore.instance.collection('users');
//         DocumentReference myDoc = usersData.doc(theUser.uid);

    // Sign in First
    UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: oldEmail, password: oldPassword);

    // Update in authentication table
    await authResult.user!.updateEmail(newEmail).then((value) {
      //  Update in users table
      FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .update({'email': newEmail}).then((value) {
        print("User Updated");
        Provider.of<AccountsProvider>(context, listen: false)
            .editEmail(newEmail);
        Navigator.pop(context);
      }).catchError((error) => print("Failed to update user: $error"));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theUser = Provider.of<AccountsProvider>(context).account!;
    CollectionReference usersData =
        FirebaseFirestore.instance.collection('users');
    return Scaffold(
        appBar: buildAppBar(context),
        body: FutureBuilder<DocumentSnapshot>(
            future: usersData.doc(theUser.id).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              String email = data['email'];
              String password = data['password'];

              return Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                          width: 320,
                          child: Text(
                            "What's your email?",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 40),
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
                          padding: const EdgeInsets.only(top: 150),
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
                                      updateUserValue(
                                          emailController.text.trim(),
                                          email,
                                          password);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.amber,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  ),
                                  child: const Text(
                                    'Update',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              )))
                    ]),
              );
            }));
  }
}
