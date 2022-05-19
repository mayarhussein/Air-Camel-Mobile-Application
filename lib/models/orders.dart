class OrdersModel {
  String id;
  String companyId;
  String clientId;
  DateTime date;
  String objType;
  String from;
  String to;
  double bill;
  int paymentType;
  String status;
  String? dimensions;
  String? weight;
  String? other;
  String? rating;

  OrdersModel(
      {required this.id,
      required this.objType,
      required this.bill,
      required this.clientId,
      required this.companyId,
      required this.date,
      required this.from,
      required this.paymentType,
      required this.status,
      required this.to,
      this.rating,
      this.other,
      this.dimensions,
      this.weight});
}
