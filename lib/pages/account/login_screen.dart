import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import '../providers/users.dart';
//import '../providers/user.dart';
//import '../screens/profile_screen.dart';

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

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;

    // LISTENER
    //var theUser = Provider.of<Users>(context, listen: false).checkLogin(
             // _emailController.toString(), 
             // _passwordController.toString());

    //if (theUser != null) {
      //Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
    //} else {
     // return;
    //}
  }

  @override
  Widget build(BuildContext context) {
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
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration:
                                  InputDecoration(labelText: 'Password'),
                              textInputAction: TextInputAction.done,
                              focusNode: _passwordFocusNode,
                              controller: _passwordController,
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
                      style: TextStyle(
                      color: Colors.white )),
                      onPressed: () => _saveForm(),
                      style: ElevatedButton.styleFrom(   
                          side: const BorderSide(width: 3, color: Colors.amber),
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          padding:
                              EdgeInsets.all(20) //content padding inside button
                          )),
                          ])))),
        ));
  }
}
