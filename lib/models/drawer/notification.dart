class NotificationModel {
  String? id;
  String message;
  String subject;
  int idFrom;
  int idTo;
  DateTime dateTime;
  bool isOpen;

  NotificationModel({
    this.id,
    required this.message,
    required this.subject,
    required this.idFrom,
    required this.idTo,
    required this.dateTime,
    required this.isOpen,
  });

  static List<NotificationModel> dummy_notifications = <NotificationModel>[
    NotificationModel(
        message: "Your package has arrived and collected",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5)),
        isOpen: false),
    NotificationModel(
        message: "There maybe a delay for 4 hours dueto bad weather",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5)),
        isOpen: true),
    NotificationModel(
        message: "Someone will arrive soon to collect your package",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5)),
        isOpen: false),
    NotificationModel(
        message: "Your package is returning",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5)),
        isOpen: true),
    NotificationModel(
        message: "Your package has arrived and collected",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5)),
        isOpen: true),
    NotificationModel(
        message: "There maybe a delay for 4 hours dueto bad weather",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5)),
        isOpen: true),
    NotificationModel(
        message: "Someone will arrive soon to collect your package",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5)),
        isOpen: true),
    NotificationModel(
        message: "You package has is returning",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5)),
        isOpen: true),
    NotificationModel(
        message: "Your package has arrived and collected",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5)),
        isOpen: true),
    NotificationModel(
        message: "There maybe a delay for 4 hours dueto bad weather",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5)),
        isOpen: true),
    NotificationModel(
        message: "Someone will arrive soon to collect your package",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5)),
        isOpen: true),
    NotificationModel(
        message: "You package has is returning",
        subject: "",
        idFrom: 0,
        idTo: 1,
        dateTime: DateTime.now().subtract(Duration(days: 5)),
        isOpen: true),
  ];
}
