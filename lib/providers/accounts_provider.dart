import 'package:air_camel/models/account.dart';
import 'package:flutter/material.dart';

class AccountsProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  Account? _account;

  void createAccount({
    required id,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
    required String image,
    required String role,
  }) {
    _account = Account(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        image: image,
        role: role);
  }

  // getter
  Account? get account {
    return _account; // returns a copy of the account
  }

  void editAccount({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
    required String image,
  }) {
    _account!.email = email;
    _account!.firstName = firstName;
    _account!.lastName = lastName;
    _account!.password = password;
    _account!.phoneNumber = phoneNumber;
    _account!.image = image;
    notifyListeners();
  }

  void editName(String firstName, String lastName) {
    _account!.firstName = firstName;
    _account!.lastName = lastName;
    notifyListeners();
  }

  void editEmail(String email) {
    _account!.email = email;
    notifyListeners();
  }

  void editPassword(String password) {
    _account!.password = password;
    notifyListeners();
  }

  void editPhoneNumber(String phoneNumber) {
    _account!.phoneNumber = phoneNumber;
    notifyListeners();
  }

  void editImage(String image) {
    _account!.image = image;
    notifyListeners();
  }
 
}
