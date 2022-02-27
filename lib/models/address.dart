import 'package:air_camel/providers/account_provider.dart';

class Address {
  int? id;
  int idAccount;
  String city;
  String area;
  String street;
  String building;
  String floor;
  String apt;

  Address({
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
