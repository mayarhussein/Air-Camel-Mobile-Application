class CategoriesModel {
  String id;
  bool isRegular;
  bool isFragile;
  bool isLarge;
  bool isMedecine;
  bool isFood;

  CategoriesModel(
      {required this.id,
      required this.isRegular,
      required this.isFragile,
      required this.isLarge,
      required this.isMedecine,
      required this.isFood});
}
