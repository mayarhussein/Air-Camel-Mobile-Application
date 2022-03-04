class OrdersModel {
  String? id;
  int companyId;
  int clientId;
  String? description;
  String? rating;
  String status;
  String from;
  String to;
  DateTime date;
  double bill;
  String paymentType;

  OrdersModel(
      {this.id,
      required this.bill,
      required this.clientId,
      required this.companyId,
      required this.date,
      this.description,
      required this.from,
      required this.paymentType,
      this.rating,
      required this.status,
      required this.to});

  static List<OrdersModel> dummy_orders = <OrdersModel>[
    OrdersModel(
        bill: 40.99,
        clientId: 0,
        companyId: 0,
        date: DateTime.now(),
        from: "Zew",
        id: "0",
        paymentType: "Cash",
        status: "Pending",
        to: "Mayoura"),
    OrdersModel(
        bill: 40.99,
        clientId: 0,
        companyId: 0,
        date: DateTime.now(),
        from: "Zew",
        id: "0",
        paymentType: "Cash",
        status: "Pending",
        to: "Mayoura"),
    OrdersModel(
        bill: 40.99,
        clientId: 0,
        companyId: 0,
        date: DateTime.now(),
        from: "Zew",
        id: "0",
        paymentType: "Cash",
        status: "Pending",
        to: "Mayoura"),
    OrdersModel(
        bill: 40.99,
        clientId: 0,
        companyId: 0,
        date: DateTime.now(),
        from: "Zew",
        id: "0",
        paymentType: "Cash",
        status: "Pending",
        to: "Mayoura"),
    OrdersModel(
        bill: 40.99,
        clientId: 0,
        companyId: 0,
        date: DateTime.now(),
        from: "Zew",
        id: "0",
        paymentType: "Cash",
        status: "Pending",
        to: "Mayoura"),
  ];
}
