class Company {
  String? id;
  String idAccount;
  bool isFood;
  bool isFragile;
  bool isMedecine;
  bool isLarge;

  Company(
      {this.id,
      required this.idAccount,
      required this.isFood,
      required this.isFragile,
      required this.isLarge,
      required this.isMedecine});
}
