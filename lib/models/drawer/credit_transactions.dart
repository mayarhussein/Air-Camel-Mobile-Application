class CreditTransactionsModel {
  String? id;
  double amount;
  String reason;
  DateTime dateTime;
  int? idAdmin;
  int? idClient;

  CreditTransactionsModel({
    this.id,
    required this.amount,
    required this.reason,
    required this.dateTime,
    this.idAdmin,
    this.idClient,
  });
}
