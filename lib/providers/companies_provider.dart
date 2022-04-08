import 'package:air_camel/models/account.dart';
import 'package:flutter/material.dart';

class CompaniesProvider with ChangeNotifier {
  List<Account>? _companiesList;

  void setCompanies(List<Account> list) {
    _companiesList = List.from(list);
  }

  List<Account> get companiesList {
    return [...?_companiesList];
  }
}
