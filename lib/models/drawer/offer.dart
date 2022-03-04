class OfferModel {
  String? id;
  int idCompany;
  DateTime dateTime;
  DateTime expireTime;
  String offerMsg;

  OfferModel({
    this.id,
    required this.idCompany,
    required this.dateTime,
    required this.expireTime,
    required this.offerMsg,
  });
}
