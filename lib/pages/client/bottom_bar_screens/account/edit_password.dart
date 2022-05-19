import 'package:air_camel/providers/accounts_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:air_camel/widgets/appbar_widget.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  EditPasswordScreenState createState() {
    return EditPasswordScreenState();
  }
}

class EditPasswordScreenState extends State<EditPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  Future<void> updateUserValue(
      String newPassword, String oldEmail, String oldPassword) async {
    FocusScope.of(context).unfocus();

    // Sign in First
    UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: oldEmail, password: oldPassword);

    // Update in authentication table
    await authResult.user!.updatePassword(newPassword).then((value) {
      //  Update in users table
      FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .update({'password': newPassword}).then((value) {
        print("User Updated");
        Provider.of<AccountsProvider>(context, listen: false)
            .editPassword(newPassword);
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
        body: StreamBuilder<DocumentSnapshot>(
            stream: usersData.doc(theUser.id).snapshots(),
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
                        width: 330,
                        child: Text(
                          "What's your new password",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                        child: SizedBox(
                            height: 100,
                            width: 320,
                            child: TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value.toString().isEmpty ||
                                    value.toString().length < 7) {
                                  return 'Password must be at least 7 characters long';
                                }
                                return null;
                              },
                              decoration:
                                  const InputDecoration(labelText: 'Password'),
                              controller: passwordController,
                            ))),
                    Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 330,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false otherwise.
                                  if (_formKey.currentState!.validate()) {
                                    updateUserValue(passwordController.text,
                                        email, password);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                child: const Text(
                                  'Update',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            )))
                  ],
                ),
              );
            }));
  }
}
