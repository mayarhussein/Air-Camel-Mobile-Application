class OfferModel {
  String? id;
  String idCompany;
  DateTime dateTime;
  DateTime expireTime;
  String offerMsg;

  OfferModel({
    required this.id,
    required this.idCompany,
    required this.dateTime,
    required this.expireTime,
    required this.offerMsg,
  });
}
