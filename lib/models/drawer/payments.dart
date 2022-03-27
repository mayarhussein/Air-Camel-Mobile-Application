class PaymentModel {
  String? id;
  double amount;
  String idCompany;
  DateTime dateTime;
  String idClient;
  String companyName;

  PaymentModel({
    this.id,
    required this.companyName,
    required this.amount,
    required this.idCompany,
    required this.dateTime,
    required this.idClient,
  });
}
