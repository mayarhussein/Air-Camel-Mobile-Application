import 'package:air_camel/models/notification.dart';
import 'package:flutter/material.dart';

class NotificationsProvider with ChangeNotifier {
  List<NotificationModel>? _notifications;

  void setNotifications(List<NotificationModel> list) {
    _notifications = List.from(list);
  }

  List<NotificationModel> get notifications {
    return [...?_notifications];
  }
}
