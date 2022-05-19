class CategoriesModel {
  String id;
  bool isRegular;
  bool isFragile;
  bool isLarge;
  bool isMedicine;
  bool isFood;

  CategoriesModel(
      {required this.id,
      required this.isRegular,
      required this.isFragile,
      required this.isLarge,
      required this.isMedicine,
      required this.isFood});
}
