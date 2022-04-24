import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String id;
  String idAccount;
  DateTime dateTime;
  String city;
  String street;
  String building;
  String floor;
  String apt;
  String? other;

  AddressModel(
      {required this.id,
      required this.idAccount,
      required this.dateTime,
      required this.city,
      required this.street,
      required this.building,
      required this.floor,
      required this.apt,
      this.other=''});
}
