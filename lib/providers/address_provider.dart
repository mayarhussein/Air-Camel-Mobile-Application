import 'package:air_camel/models/address.dart';
import 'package:flutter/foundation.dart';

class AddressProvider with ChangeNotifier {
  List<AddressModel>? _addressList;

  void setAddress(List<AddressModel> list) {
    _addressList = List.from(list);
  }

List<AddressModel> get addressList{
  return [...?_addressList];

}

}
