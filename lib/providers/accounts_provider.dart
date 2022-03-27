import 'dart:convert';
import 'package:air_camel/models/account.dart';
import 'package:air_camel/others/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  // AccountProvider findById(String id) {
  //   return _items.firstWhere((account) => account.id == id);
  // }

  // AccountProvider checkLogin(String email, String password) {
  //   return _items.firstWhere((account) =>
  //       (account.email == email) && (account.password == password));
  // }

  // FETCH Accounts
//   Future<void> fetchAndSetAccounts() async {
//     const url = 'https://air-camel-default-rtdb.firebaseio.com/accounts.json';
//     try {
//       // GET REQUEST
//       final response = await http.get(Uri.parse(url));
//       //print(json.decode(response.body));
//       final extractedData = json.decode(response.body) as Map<String, dynamic>;
//       //final List<AccountProvider> loadedAccounts = [];
//       if (extractedData == null) return;

//       extractedData.forEach((accountID, accountData) {
//         loadedAccounts.add(AccountProvider(
//           id: accountID,
//           firstName: accountData['firstName'],
//           lastName: accountData['lastName'],
//           email: accountData['email'],
//           password: accountData['password'],
//           phoneNumber: accountData['phoneNumber'],
//           role: accountData['role'],
//         ));
//       });
//       _items = loadedAccounts;
//       notifyListeners();
//     } catch (error) {
//       throw (error);
//     }
//   }

//   // ADD ACCOUNT
//   // async automatically returns a future
//   Future<void> addAccount(AccountProvider account) async {
//     // creates a database collection called products
//     const url = 'https://air-camel-default-rtdb.firebaseio.com/accounts.json';

//     try {
//       // POST REQUEST
//       final response = await http.post(Uri.parse(url),
//           body: json.encode({
//             // converts from map to json
//             'firstName': account.firstName,
//             'lastName': account.lastName,
//             'email': account.email,
//             'password': account.password,
//             'phoneNumber': account.phoneNumber,
//             'role': account.role
//           }));

//       //print(json.decode(response.body)); // converts from json to map

//       final newAccount = AccountProvider(
//         id: json.decode(response.body)['name'],
//         firstName: account.firstName,
//         lastName: account.lastName,
//         email: account.email,
//         password: account.password,
//         phoneNumber: account.phoneNumber,
//         role: account.role,
//       );

//       _items.add(newAccount); // at the end of the list
//       //  _items.insert(0, newProduct);    // at the start of the list

//       notifyListeners(); // Notify all listeners so they can get rebuilt

//     } catch (error) {
//       print(error);
//       throw error;
//     }
//   }

// // UPDATE
//   Future<void> updateProduct(String id, AccountProvider newAccount) async {
//     final accIndex = _items.indexWhere((account) => account.id == id);

//     if (accIndex >= 0) {
//       final url =
//           'https://air-camel-default-rtdb.firebaseio.com/accounts/$id.json';

//       // PATCH REQUEST
//       await http.patch(Uri.parse(url),
//           body: json.encode({
//             'firstName': newAccount.firstName,
//             'lastName': newAccount.lastName,
//             'email': newAccount.email,
//             'password': newAccount.password,
//             'phoneNumber': newAccount.phoneNumber,
//             'role': newAccount.role
//           }));

//       _items[accIndex] = newAccount;
//       notifyListeners();
//     } else {
//       print('...');
//     }
//   }

// // DELETE
//   Future<void> deleteProduct(String id) async {
//     final url =
//         'https://air-camel-default-rtdb.firebaseio.com/accounts/$id.json';
//     final existingAccountIndex =
//         _items.indexWhere((account) => account.id == id);
//     AccountProvider? existingProduct =
//         _items[existingAccountIndex]; // item reference

//     _items.removeAt(existingAccountIndex);
//     notifyListeners();

//     // DELETE REQUEST
//     final response = await http.delete(Uri.parse(url));

//     if (response.statusCode >= 400) {
//       // Re-adds the product to the list on failure
//       _items.insert(existingAccountIndex, existingProduct);
//       notifyListeners();
//       throw HttpException('could not delete product');
//     } else {
//       // if no error
//       existingProduct = null;
//     }
//   }
}
