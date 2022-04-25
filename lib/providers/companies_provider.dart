import 'package:air_camel/models/account.dart';
import 'package:air_camel/models/categories.dart';
import 'package:air_camel/others/filters_list.dart';
import 'package:flutter/material.dart';

class CompaniesProvider with ChangeNotifier {
  List<Account>? _companiesList;
  List<Account>? _filteredCompaniesList;
  List<CategoriesModel>? _categoriesList;

  List<Account> setFilter(List<FilterListData> list) {
    print('--------------');
    print(list.length);
    list.forEach((element) => {print(element.titleTxt)});
    list.forEach((element) => {print(element.isSelected)});
    print('*********');

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
            element.isMedecine ==
                (list
                        .firstWhere((element) => element.titleTxt == "Medecine")
                        .isSelected ||
                    element.isMedecine) &&
            element.isRegular ==
                (list
                        .firstWhere((element) => element.titleTxt == "Regular")
                        .isSelected ||
                    element.isRegular))
        .map((item) {
      return item.id;
    });

    print(listID);
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
