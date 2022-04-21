class OfferModel {
  String? id;
  String idCompany;
  DateTime dateTime;
  DateTime expireTime;
  String offerMsg;
  bool isExpired;

  OfferModel({
    required this.id,
    required this.idCompany,
    required this.dateTime,
    required this.expireTime,
    required this.offerMsg,
    required this.isExpired
  });
}
