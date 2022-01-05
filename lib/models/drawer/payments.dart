class Payment {
  double amount;
  int idCompany;
  DateTime dateTime;
  int idClient;

  Payment({
    required this.amount,
    required this.idCompany,
    required this.dateTime,
    required this.idClient,
  });

  static List<Payment> paymentList = <Payment>[
    Payment(
        amount: 500,
        idCompany: 0,
        dateTime: DateTime.now().subtract(Duration(days: 5)),
        idClient: 0),
    Payment(
        amount: -400,
        idCompany: 0,
        dateTime: DateTime.now().subtract(Duration(days: 3)),
        idClient: 0),
    Payment(
        amount: 544,
        idCompany: 0,
        dateTime: DateTime.now().subtract(Duration(days: 1)),
        idClient: 0),
    Payment(amount: 2323, idCompany: 0, dateTime: DateTime.now(), idClient: 0),
    Payment(
        amount: 44,
        idCompany: 0,
        dateTime: DateTime.now().subtract(Duration(days: 9)),
        idClient: 0),
  ];
}
