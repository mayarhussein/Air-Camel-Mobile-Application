import 'package:air_camel/pages/company/edit_categories.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../models/categories.dart';

class CategoriesProvider with ChangeNotifier {
  CategoriesModel? _categories;

  void setCategories(
      {required String id,
      required bool isRegular,
      required bool isFragile,
      required bool isLarge,
      required bool isMedicine,
      required bool isFood}) {
    _categories = CategoriesModel(
        id: id,
        isRegular: isRegular,
        isFragile: isFragile,
        isLarge: isLarge,
        isMedicine: isMedicine,
        isFood: isFood);
  }

  // getter
  CategoriesModel? get categories {
    return _categories;
  }

  void EditCategories(bool isRegular, bool isFragile, bool isLarge,
      bool isMedicine, bool isFood) {
    _categories!.isRegular = isRegular;
    _categories!.isFragile = isFragile;
    _categories!.isLarge = isLarge;
    _categories!.isMedicine = isMedicine;
    _categories!.isFood = isFood;

    notifyListeners();
  }
}
