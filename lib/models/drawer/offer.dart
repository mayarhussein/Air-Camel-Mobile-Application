class OfferModel {
  String? id;
  String idCompany;
  DateTime dateTime;
  DateTime expireTime;
  String offerMsg;
  bool isExpired;
  bool isFeatured;

  OfferModel(
      {required this.id,
      required this.idCompany,
      required this.dateTime,
      required this.expireTime,
      required this.offerMsg,
      required this.isExpired,
      required this.isFeatured});
}
