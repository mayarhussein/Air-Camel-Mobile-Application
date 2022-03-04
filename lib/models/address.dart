class AddressModel {
  String? id;
  int idAccount;
  String city;
  String area;
  String street;
  String building;
  String floor;
  String apt;

  AddressModel({
    this.id,
    required this.idAccount,
    required this.city,
    required this.apt,
    required this.area,
    required this.floor,
    required this.street,
    required this.building,
  });
}
