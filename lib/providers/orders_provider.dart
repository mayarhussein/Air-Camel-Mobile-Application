import 'package:air_camel/models/orders.dart';
import 'package:flutter/material.dart';

class OrdersProvider with ChangeNotifier {
  List<OrdersModel>? _orderList;

  void setOrder(List<OrdersModel> list) {
    _orderList = List.from(list);
  }

  List<OrdersModel> myPendingOrders(String id) {
    return [
      ..._orderList!.where(
          (element) => element.companyId == id && element.status == "pending")
    ];
  }
}
