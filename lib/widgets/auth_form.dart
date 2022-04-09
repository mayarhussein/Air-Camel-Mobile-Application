import 'dart:io';
import 'package:air_camel/widgets/user_image_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

enum Role { client, company }

class AuthForm extends StatefulWidget {
  // Passing parameters: This function will be called inside this widget
  // but the parameters will get passed to outside this widget
  final void Function(
      String email,
      String password,
      String firstName,
      String lastName,
      String phoneNumber,
      String city,
      String street,
      String building,
      String floor,
      String apt,
      Role? role,
      File imageURL,
      bool isLogin,
      BuildContext ctx) submitFn;

  final bool isLoading;

  AuthForm(this.submitFn, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

// _ : private

class _AuthFormState extends State<AuthForm> {
  Role? _role = Role.client;

  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userFirstName = '';
  String _userLastName = '';
  String _userPhoneNumber = '';
  String _userPassword = '';
  String _userCity = '';
  String _userStreet = '';
  String _userBuilding = '';
  String _userFloor = '';
  String _userApt = '';
  File? _userImageFile;

  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _streetFocusNode = FocusNode();
  final _buildingFocusNode = FocusNode();
  final _floorFocusNode = FocusNode();
  final _aptFocusNode = FocusNode();

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _passwordFocusNode.dispose();
    _cityFocusNode.dispose();
    _streetFocusNode.dispose();
    _buildingFocusNode.dispose();
    _floorFocusNode.dispose();


    super.dispose();
  }

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: const Text('Please pick an image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      // triggers onSaved() in every textFormField
      _formKey.currentState!.save();

      // will send the parameters to _submitAuthForm function in AuthScreen
      widget.submitFn(
          _userEmail.trim(),
          _userPassword.trim(),
          _userFirstName.trim(),
          _role == Role.client ? _userLastName.trim() : 'Company',
          _userPhoneNumber.trim(),
          _userCity.trim(),
          _userStreet.trim(),
          _userBuilding.trim(),
          _userFloor.trim(),
          _userApt.trim(),
          _role,
          _userImageFile as File,
          _isLogin,
          context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (!_isLogin) UserImagePicker(_pickedImage),
                    if (!_isLogin)
                      Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text('Client'),
                            leading: Radio<Role>(
                              value: Role.client,
                              groupValue: _role,
                              onChanged: (Role? value) {
                                setState(() {
                                  _role = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Company'),
                            leading: Radio<Role>(
                              value: Role.company,
                              groupValue: _role,
                              onChanged: (Role? value) {
                                setState(() {
                                  _role = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    if (!_isLogin)
                      TextFormField(
                        key: const ValueKey('firstName'),
                        decoration: InputDecoration(
                            labelText:
                                _role == Role.client ? 'First Name' : 'Name'),
                        focusNode: _firstNameFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          } else if (!isAlpha(value)) {
                            return 'Only Letters Please';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userFirstName = value.toString();
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_lastNameFocusNode);
                        },
                      ),
                    if (!_isLogin && _role == Role.client)
                      TextFormField(
                        key: const ValueKey('lastName'),
                        decoration:
                            const InputDecoration(labelText: 'Last Name'),
                        focusNode: _lastNameFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          } else if (!isAlpha(value)) {
                            return 'Only Letters Please';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userLastName = value.toString();
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                      ),
                    TextFormField(
                      key: const ValueKey('email'),
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          const InputDecoration(labelText: 'Email Address'),
                      focusNode: _emailFocusNode,
                      validator: (value) {
                        if (value.toString().isEmpty ||
                            !EmailValidator.validate(value.toString())) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      onSaved: (value) {
                        _userEmail = value.toString();
                      },
                    ),
                    TextFormField(
                      key: const ValueKey('password'),
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      focusNode: _passwordFocusNode,
                      validator: (value) {
                        if (value.toString().isEmpty ||
                            value.toString().length < 7) {
                          return 'Password must be at least 7 characters long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userPassword = value.toString();
                      },
                      onFieldSubmitted: (_) {
                        if (_isLogin) {
                          _trySubmit();
                        } else {
                          FocusScope.of(context)
                              .requestFocus(_cityFocusNode);
                        }
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: const ValueKey('city'),
                        decoration: const InputDecoration(labelText: 'City'),
                        focusNode: _cityFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a city';
                          } else if (!isAlpha(value)) {
                            return 'Only Letters Please';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userCity = value.toString();
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_streetFocusNode);
                        },
                      ),
                       if (!_isLogin)
                      TextFormField(
                        key: const ValueKey('street'),
                        decoration: const InputDecoration(labelText: 'Street'),
                        focusNode: _streetFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a street';
                          } 
                          return null;
                        },
                        onSaved: (value) {
                          _userStreet = value.toString();
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_buildingFocusNode);
                        },
                      ),
                      Row(
                        
                        children: <Widget>[
                            if (!_isLogin) 
                       SizedBox(
                          width: 150,
                          child: TextFormField(
                  
                        key: const ValueKey('building'),
                        decoration: const InputDecoration(labelText: 'Building'),
                        focusNode: _buildingFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a building';
                          } 
                          return null;
                        },
                        onSaved: (value) {
                          _userBuilding = value.toString();
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_floorFocusNode);
                        },
                      )),
                      if (!_isLogin)
                         SizedBox(
                          width: 150,
                          child: TextFormField(
                        key: const ValueKey('floor'),
                        decoration: const InputDecoration(labelText: 'Floor'),
                        focusNode: _floorFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a floor';
                          } 
                          return null;
                        },
                        onSaved: (value) {
                          _userFloor = value.toString();
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_aptFocusNode);
                        },
                      ),)
                        ],
                      ),
                       
                      if (!_isLogin)
                      TextFormField(
                        key: const ValueKey('apt'),
                        decoration: const InputDecoration(labelText: 'Apt'),
                        focusNode: _aptFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an apartment';
                          } 
                          return null;
                        },
                        onSaved: (value) {
                          _userApt = value.toString();
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
                        },
                      ),



                    if (!_isLogin)
                      TextFormField(
                        key: const ValueKey('phoneNumber'),
                        decoration:
                            const InputDecoration(labelText: 'Phone Number'),
                        focusNode: _phoneNumberFocusNode,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (isAlpha(value)) {
                            return 'Only Numbers Please';
                          } else if (value.length < 10) {
                            return 'Please enter a VALID phone number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userPhoneNumber = value.toString();
                        },
                        onFieldSubmitted: (_) {
                          _trySubmit();
                        },
                      ),
                    const SizedBox(height: 12),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      ElevatedButton(
                          child: Text(_isLogin ? 'Login' : 'Sign Up',
                              style: const TextStyle(color: Colors.white)),
                          onPressed: _trySubmit,
                          style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  width: 3, color: Colors.amber),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              padding: const EdgeInsets.all(
                                  20) //content padding inside button
                              )),
                    if (!widget.isLoading)
                      TextButton(
                        child: Text(
                            _isLogin
                                ? 'Create New Account'
                                : 'I already have an account',
                            style: const TextStyle(
                                decoration: TextDecoration.underline)),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                      )
                  ],
                )),
          ),
        ),
      ),
    ));
  }
}
