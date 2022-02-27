class CreditTransactions {
  int? id;
  double amount;
  String reason;
  DateTime dateTime;
  int idAdmin;
  int idClient;

  CreditTransactions({
    this.id,
    required this.amount,
    required this.reason,
    required this.dateTime,
    required this.idAdmin,
    required this.idClient,
  });
}
