import 'package:air_camel/models/drawer/offer.dart';
import 'package:flutter/material.dart';

class OffersProvider with ChangeNotifier {
  List<OfferModel>? _offers;

  void setOffers(List<OfferModel> list) {
    _offers = List.from(list);
  }

  List<OfferModel> get offers {
    return [...?_offers];
  }

  List<OfferModel> validOffers() {
    return [...?_offers].where((element) => !element.isExpired).toList();
  }
}
