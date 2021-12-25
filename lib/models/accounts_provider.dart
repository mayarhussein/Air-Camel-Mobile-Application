import 'dart:convert';
import 'package:air_camel/models/account_provider.dart';
import 'package:air_camel/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './account_provider.dart';


class AccountsProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<AccountProvider> _items = [];

  var _showFavoritesOnly = false;

  // getter
  List<AccountProvider> get items {
    return [..._items]; // returns a copy of the list
  }

  

  AccountProvider findById(String id) {
    return _items.firstWhere((account) => account.id == id);
  }

  // Fetch Accounts
  Future<void> fetchAndSetAccounts() async {
    const url = 'https://air-camel-default-rtdb.firebaseio.com/accounts.json';
    try {
      // GET REQUEST
      final response = await http.get(Uri.parse(url));
      //print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<AccountProvider> loadedAccounts = [];
        if (extractedData == null) return;

      extractedData.forEach((accountID, accountData) {
        loadedAccounts.add(AccountProvider(
            id: accountID,
            firstName: accountData['firstName'],
            lastName: accountData['lastName'],
            email: accountData['email'],
            password: accountData['password'],
            phoneNumber: accountData['phoneNumber'],
            role: accountData['role'],

            ));
      });
      _items = loadedAccounts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  // async automatically returns a future
  Future<void> addAccount(AccountProvider account) async {
    // creates a database collection called products
    const url = 'https://air-camel-default-rtdb.firebaseio.com/accounts.json';
   
    try {
       // POST REQUEST
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            // converts from map to json
            'firstName': account.firstName,
            'lastName': account.lastName,
            'email': account.email,
            'password': account.password,
            'phoneNumber': account.phoneNumber,
            'role': account.role
          }));

      //print(json.decode(response.body)); // converts from json to map

      final newAccount = AccountProvider(
          id: json.decode(response.body)['name'],
          firstName: account.firstName,
          lastName: account.lastName,
          email: account.email,
          password: account.password,
          phoneNumber: account.phoneNumber,
          role: account.role,
          );

      _items.add(newAccount); // at the end of the list
      //  _items.insert(0, newProduct);    // at the start of the list

      notifyListeners(); // Notify all listeners so they can get rebuilt

    } catch (error) {
      print(error);
      throw error;
    }

  }

  Future<void> updateProduct(String id, AccountProvider newAccount) async {
    final accIndex = _items.indexWhere((account) => account.id == id);

    if (accIndex >= 0) {
      final url = 'https://air-camel-default-rtdb.firebaseio.com/accounts/$id.json';
      
      // PATCH REQUEST
      await http.patch(Uri.parse(url),
          body: json.encode({
              'firstName': newAccount.firstName,
            'lastName': newAccount.lastName,
            'email': newAccount.email,
            'password': newAccount.password,
            'phoneNumber': newAccount.phoneNumber,
            'role': newAccount.role
          }));

      _items[accIndex] = newAccount;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://air-camel-default-rtdb.firebaseio.com/accounts/$id.json';
    final existingAccountIndex = _items.indexWhere((account) => account.id == id);
    AccountProvider? existingProduct =
        _items[existingAccountIndex]; // item reference

    _items.removeAt(existingAccountIndex);
    notifyListeners();

    // DELETE REQUEST 
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode >= 400) {
      // Re-adds the product to the list on failure
      _items.insert(existingAccountIndex, existingProduct);
      notifyListeners();
      throw HttpException('could not delete product');

    } else { // if no error
         existingProduct = null;
    }
  }
}
