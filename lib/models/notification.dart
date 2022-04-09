class NotificationModel {
  String? id;
  String message;
  String subject;
  String idFrom;
  String idTo;
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

  
}
