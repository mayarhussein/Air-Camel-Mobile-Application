import 'package:air_camel/models/account_provider.dart';
import 'package:air_camel/models/accounts_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var newAccount = AccountProvider(
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      password: '',
      phoneNumber: '',
      role: '');

  var _isInit = true;
  var _isLoading = false;

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _phoneNumberFocusNode.dispose();

    super.dispose();
  }

  Future<void> _saveForm() async {
    final isVAlid = _form.currentState!.validate();
    if (!isVAlid) return;
    _form.currentState!.save();

    //because I want to reflect these changes on user interface
    setState(() {
      _isLoading = true;
    });

    try {
      // LISTENER : set to false bec i'm not interested in any changes in Product Provider
      await Provider.of<AccountsProvider>(context, listen: false)
          .addAccount(newAccount);
    } catch (error) {
      print(error);
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                  title: const Text('An error occured!'),
                  content: const Text('Something went wrong'),
                  actions: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // To close the dialoge
                        },
                        child: const Text('Okay'))
                  ]));
    }

    // happens when one of 2 awaits is executed
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop(); // go back to prev page
  }

  // void _saveForm() {
  //   final isValid = _form.currentState!.validate();
  //   if (!isValid) {
  //     return;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final role = ModalRoute.of(context)!.settings.arguments;
    print(role);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Register',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'WorkSans-Regular')),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              color: Theme.of(context).errorColor,
              onPressed: () => {Navigator.of(context).pop()},
            ),
          ],
        ),
        body: Container(
          child: Card(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 60),
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Form(
                      key: _form,
                      child: ListView(padding: EdgeInsets.all(10), children: <
                          Widget>[
                        Icon(
                          CupertinoIcons.person_3,
                          size: 60,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(labelText: 'First Name'),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_lastNameFocusNode);
                          },
                          validator: (value) {
                            if (value.toString().isEmpty)
                              return 'This field is REQUIRED';
                          },
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(labelText: 'Last Name'),
                          textInputAction: TextInputAction.next,
                          focusNode: _lastNameFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_emailFocusNode);
                          },
                          validator: (value) {
                            if (value.toString().isEmpty)
                              return 'This field is REQUIRED';
                          },
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(labelText: 'Email'),
                          textInputAction: TextInputAction.next,
                          focusNode: _emailFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                          validator: (value) {
                            if (value.toString().isEmpty)
                              return 'This field is REQUIRED';
                          },
                        ),
                        TextFormField(
                            style: TextStyle(color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(labelText: 'Password'),
                            textInputAction: TextInputAction.next,
                            focusNode: _passwordFocusNode,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_phoneNumberFocusNode);
                            }),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          obscureText: true,
                          decoration:
                              InputDecoration(labelText: 'Phone Number'),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          focusNode: _phoneNumberFocusNode,
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                              child: Text('SIGNUP',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () => _saveForm(),
                              style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                      width: 3, color: Colors.amber),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  padding: EdgeInsets.all(
                                      20) //content padding inside button
                                  )),
                        )
                      ])))),
        ));
  }
}
