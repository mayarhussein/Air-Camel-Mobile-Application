class ComplaintsModel {
  String? id;
  String clientName;
  int companyId;
  int clientId;
  DateTime date;
  String body;

  ComplaintsModel(
      {this.id,
      required this.clientName,
      required this.clientId,
      required this.companyId,
      required this.date,
      required this.body});

  static List<ComplaintsModel> dummy_complaints = <ComplaintsModel>[
    ComplaintsModel(
        id: "0",
        clientId: 0,
        companyId: 0,
        date: DateTime.now(),
        clientName: "Mayar",
        body: "The order arrived too late"),
    ComplaintsModel(
        id: "0",
        clientId: 0,
        companyId: 0,
        date: DateTime.now(),
        clientName: "Youssef",
        body: "The order was never received"),
    ComplaintsModel(
        id: "0",
        clientId: 0,
        companyId: 0,
        date: DateTime.now(),
        clientName: "John",
        body: "The delivery guy was so rude"),
    ComplaintsModel(
        id: "0",
        clientId: 0,
        companyId: 0,
        date: DateTime.now(),
        clientName: "Mayar",
        body: "took too many days to arrive"),
    ComplaintsModel(
        id: "0",
        clientId: 0,
        companyId: 0,
        date: DateTime.now(),
        clientName: "Mayar",
        body: "wrong package arrived"),
  ];
}
