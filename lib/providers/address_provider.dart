import 'package:air_camel/models/address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AddressProvider with ChangeNotifier {
  List<AddressModel>? _addressList;

  void setAddress(List<AddressModel> list) {
    _addressList = List.from(list);
  }

List<AddressModel> get address{
  return [...?_addressList];

}



}
