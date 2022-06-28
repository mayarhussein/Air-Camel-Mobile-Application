import 'package:air_camel/models/account.dart';
import 'package:air_camel/models/categories.dart';
import 'package:air_camel/others/filters_list.dart';
import 'package:flutter/material.dart';

class CompaniesProvider with ChangeNotifier {
  List<Account>? _companiesList;
  List<Account>? _filteredCompaniesList;
  List<CategoriesModel>? _categoriesList;

  List<Account> setFilter(List<FilterListData> list) {
    var listID = _categoriesList!
        .where((element) =>
            element.isFragile ==
                (list
                        .firstWhere((element) => element.titleTxt == "Fragile")
                        .isSelected ||
                    element.isFragile) &&
            element.isFood ==
                (list
                        .firstWhere((element) => element.titleTxt == "Food")
                        .isSelected ||
                    element.isFood) &&
            element.isLarge ==
                (list
                        .firstWhere((element) => element.titleTxt == "Large")
                        .isSelected ||
                    element.isLarge) &&
            element.isMedicine ==
                (list
                        .firstWhere((element) => element.titleTxt == "medicine")
                        .isSelected ||
                    element.isMedicine) &&
            element.isRegular ==
                (list
                        .firstWhere((element) => element.titleTxt == "Regular")
                        .isSelected ||
                    element.isRegular))
        .map((item) {
      return item.id;
    });

    _filteredCompaniesList =
        companiesList.where((element) => listID.contains(element.id)).toList();
    notifyListeners();
    return [...?_filteredCompaniesList];
  }

  void setCompanies(List<Account> list) {
    _companiesList = List.from(list);
  }

  void setCategories(List<CategoriesModel> list) {
    _categoriesList = List.from(list);
  }

  List<Account> get filteredCompaniesList {
    return [...?_filteredCompaniesList];
  }

  List<Account> get companiesList {
    return [...?_companiesList];
  }
}
