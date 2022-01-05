class Notification {
  String message;
  String subject;
  int idFrom;
  int idTo;
  DateTime dateTime;

  Notification({
    required this.message,
    required this.subject,
    required this.idFrom,
    required this.idTo,
    required this.dateTime,
  });
}
