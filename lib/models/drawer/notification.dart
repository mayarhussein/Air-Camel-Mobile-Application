class NotificationModel {
  int? id;
  String message;
  String subject;
  int idFrom;
  int idTo;
  DateTime dateTime;

  NotificationModel({
    this.id,
    required this.message,
    required this.subject,
    required this.idFrom,
    required this.idTo,
    required this.dateTime,
  });

  static List<NotificationModel> dummy_notifications = <NotificationModel>[
    NotificationModel(
        message: "Your package has arrived and collected",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5))),
    NotificationModel(
        message: "There maybe a delay for 4 hours dueto bad weather",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5))),
    NotificationModel(
        message: "Someone will arrive soon to collect your package",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5))),
    NotificationModel(
        message: "Your package is returning",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5))),
    NotificationModel(
        message: "Your package has arrived and collected",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5))),
    NotificationModel(
        message: "There maybe a delay for 4 hours dueto bad weather",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5))),
    NotificationModel(
        message: "Someone will arrive soon to collect your package",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5))),
    NotificationModel(
        message: "You package has is returning",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5))),
    NotificationModel(
        message: "Your package has arrived and collected",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5))),
    NotificationModel(
        message: "There maybe a delay for 4 hours dueto bad weather",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5))),
    NotificationModel(
        message: "Someone will arrive soon to collect your package",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5))),
    NotificationModel(
        message: "You package has is returning",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5))),
  ];
}
