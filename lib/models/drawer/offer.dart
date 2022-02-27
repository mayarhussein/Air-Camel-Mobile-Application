class Offer {
  int? id;
  int idCompany;
  DateTime dateTime;
  DateTime expireTime;
  String offerMsg;

  Offer({
    this.id,
    required this.idCompany,
    required this.dateTime,
    required this.expireTime,
    required this.offerMsg,
  });
}
