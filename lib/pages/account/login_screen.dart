import 'package:air_camel/models/accounts_provider.dart';
import 'package:air_camel/models/account_provider.dart';
import 'package:air_camel/pages/home/navigation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _passwordFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var _isInit = true;
  var _isLoading = false;

  late var _email;
  late var _password;

  @override
  void dispose() {
    _passwordFocusNode.dispose();
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

    print(_email);
    print(_password);

    Navigator.of(context).pushNamed(NavigationHomeScreen.routeName);

    // try {
    //   // LISTENER : set to false bec i'm not interested in any changes in Account Provider
    //   AccountProvider theAccount =
    //       Provider.of<AccountsProvider>(context, listen: false)
    //           .checkLogin(_email, _password);

    //   print(theAccount);

    //   if (theAccount != null) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //     //Navigator.of(context).pop(); // go back to prev page
    //     Navigator.of(context).pushNamed(NavigationHomeScreen.routeName,
    //         arguments: theAccount.id);
    //   }
    // } catch (error) {
    //   print(error);
    //   await showDialog(
    //       context: context,
    //       builder: (ctx) => AlertDialog(
    //               title: const Text('An error occured!'),
    //               content: const Text('Something went wrong'),
    //               actions: <Widget>[
    //                 ElevatedButton(
    //                     child: const Text('Okay'),
    //                     onPressed: () {
    //                       Navigator.of(context).pop(); // To close the dialoge
    //                       setState(() {
    //                         _isLoading = false;
    //                       });
    //                     })
    //               ]));
    // }
  }

//  void _saveForm() {
//     final isValid = _form.currentState!.validate();
//     if (!isValid) {
//       return;
//     }
//     Navigator.of(context).pushNamed(NavigationHomeScreen.routeName);
//   }

 
  @override
  Widget build(BuildContext context) {
    final role = ModalRoute.of(context)!.settings.arguments;
    print(role);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login',
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
                      child: ListView(
                          padding: EdgeInsets.all(10),
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.person_3,
                              size: 60,
                            ),
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(labelText: 'Email'),
                              textInputAction: TextInputAction.next,
                              controller: _emailController,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                              validator: (value) {
                                if (value.toString().isEmpty)
                                  return 'Please enter email';
                              },
                              onSaved: (value) => _email = value.toString(),
                            ),
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              obscureText: true,
                              decoration:
                                  InputDecoration(labelText: 'Password'),
                              textInputAction: TextInputAction.done,
                              focusNode: _passwordFocusNode,
                              controller: _passwordController,
                              onSaved: (value) => _password = value.toString(),
                              onFieldSubmitted: (_) {
                                _saveForm();
                              },
                            ),
                            TextButton(
                              child: Text("Forget password?"),
                              onPressed: () {},
                            ),
                            ElevatedButton(
                                child: Text('LOGIN',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () => _saveForm(),
                                style: ElevatedButton.styleFrom(
                                    side: const BorderSide(
                                        width: 3, color: Colors.amber),
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    padding: EdgeInsets.all(
                                        20) //content padding inside button
                                    )),
                          ])))),
        ));
  }
}
