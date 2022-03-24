import 'package:air_camel/models/drawer/notification.dart';
import 'package:flutter/material.dart';

class NotificationsProvider with ChangeNotifier {
  List<NotificationModel> _notifications = [];

  void setNotifications(List<NotificationModel> list) {
    _notifications = List.from(list);
    notifyListeners();
  }

  int notificationsLength() {
    return _notifications.length;
  }
}
