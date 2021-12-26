import 'package:air_camel/models/account_provider.dart';
import 'package:air_camel/models/accounts_provider.dart';
import 'package:air_camel/pages/home/navigation_screen.dart';
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

  var _newAccount = AccountProvider(
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
          .addAccount(_newAccount);

    setState(() {
      _isLoading = false;
    });
       //Navigator.of(context).pop(); // go back to prev page
    Navigator.of(context)
        .pushNamed(NavigationHomeScreen.routeName, arguments: _newAccount.id);
      
    } catch (error) {
      print(error);
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                  title: const Text('An error occured!'),
                  content: const Text('Something went wrong'),
                  actions: <Widget>[
                    ElevatedButton(
                        child: const Text('Okay'),
                        onPressed: () {
                          Navigator.of(context).pop(); // To close the dialoge
                           setState(() {
                             _isLoading = false;
                                       });
                  })])
              );      
                  
        }  
  }

  @override
  Widget build(BuildContext context) {
    final role = ModalRoute.of(context)!.settings.arguments;
    print(role);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Register',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'WorkSans-Regular')),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.close),
              color: Theme.of(context).errorColor,
              onPressed: () => {Navigator.of(context).pop()},
            ),
          ],
        ),
        body: Container(
          child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Form(
                      key: _form,
                      child: ListView(
                          padding: const EdgeInsets.all(10),
                          children: <Widget>[
                            const Icon(
                              CupertinoIcons.person_3,
                              size: 60,
                            ),
                            TextFormField(
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                    labelText: 'First Name'),
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_lastNameFocusNode);
                                },
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'This field is REQUIRED';
                                  }
                                },
                                onSaved: (value) {
                                  _newAccount = AccountProvider(
                                      id: _newAccount.id,
                                      firstName: value.toString(),
                                      lastName: _newAccount.lastName,
                                      email: _newAccount.email,
                                      password: _newAccount.password,
                                      phoneNumber: _newAccount.phoneNumber,
                                      role: role.toString().substring(5));
                                }),
                            TextFormField(
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                    labelText: 'Last Name'),
                                textInputAction: TextInputAction.next,
                                focusNode: _lastNameFocusNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_emailFocusNode);
                                },
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'This field is REQUIRED';
                                  }
                                },
                                onSaved: (value) {
                                  _newAccount = AccountProvider(
                                      id: _newAccount.id,
                                      firstName: _newAccount.firstName,
                                      lastName: value.toString(),
                                      email: _newAccount.email,
                                      password: _newAccount.password,
                                      phoneNumber: _newAccount.phoneNumber,
                                      role: role.toString().substring(5));
                                }),
                            TextFormField(
                                style: const TextStyle(color: Colors.black),
                                decoration:
                                    const InputDecoration(labelText: 'Email'),
                                textInputAction: TextInputAction.next,
                                focusNode: _emailFocusNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_passwordFocusNode);
                                },
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'This field is REQUIRED';
                                  }
                                },
                                onSaved: (value) {
                                  _newAccount = AccountProvider(
                                      id: _newAccount.id,
                                      firstName: _newAccount.firstName,
                                      lastName: _newAccount.lastName,
                                      email: value.toString(),
                                      password: _newAccount.password,
                                      phoneNumber: _newAccount.phoneNumber,
                                      role: role.toString().substring(5));
                                }),
                            TextFormField(
                                style: const TextStyle(color: Colors.black),
                                obscureText: true,
                                decoration: const InputDecoration(
                                    labelText: 'Password'),
                                textInputAction: TextInputAction.next,
                                focusNode: _passwordFocusNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_phoneNumberFocusNode);
                                },
                                onSaved: (value) {
                                  _newAccount = AccountProvider(
                                      id: _newAccount.id,
                                      firstName: _newAccount.firstName,
                                      lastName: _newAccount.lastName,
                                      email: _newAccount.email,
                                      password: value.toString(),
                                      phoneNumber: _newAccount.phoneNumber,
                                      role: role.toString().substring(5));
                                }),
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              obscureText: true,
                              decoration: const InputDecoration(
                                  labelText: 'Phone Number'),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              focusNode: _phoneNumberFocusNode,
                              onFieldSubmitted: (_) {
                                _saveForm();
                              },
                              onSaved: (value) {
                                _newAccount = AccountProvider(
                                    id: _newAccount.id,
                                    firstName: _newAccount.firstName,
                                    lastName: _newAccount.lastName,
                                    email: _newAccount.email,
                                    password: _newAccount.password,
                                    phoneNumber: value.toString(),
                                    role: role.toString().substring(5));
                              },
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: ElevatedButton(
                                  child: const Text('SIGNUP',
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () => _saveForm(),
                                  style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                          width: 3, color: Colors.amber),
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      padding: const EdgeInsets.all(
                                          20) //content padding inside button
                                      )),
                            )
                          ])))),
        ));
  }
}
