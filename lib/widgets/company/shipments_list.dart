import 'package:air_camel/models/orders.dart';
import 'package:air_camel/providers/accounts_provider.dart';
import 'package:air_camel/providers/orders_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../constants.dart';

class ShipmentsList extends StatelessWidget {
  _acceptOrder(String orderId, String userId, String companyId) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .update({'status': 'accepted'});
    _sendNotification(
        userId,
        companyId,
        "We are glad to inform you that you order has been accepted",
        "Order update");
  }

  _rejectOrder(String orderId, String userId, String companyId) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .update({'status': 'accepted'});

    _sendNotification(
        userId,
        companyId,
        "We are sincerely sorry to inform you that you order has been rejcted",
        "Order update");
  }

  _sendNotification(
      String userId, String companyId, String msg, String subj) async {
    var randomId = const Uuid().v4();

    await FirebaseFirestore.instance
        .collection('users/$userId/notifications')
        .doc(randomId)
        .set({
      'id': randomId,
      'message': msg,
      'subject': subj,
      'idFrom': companyId,
      'idTo': userId,
      'dateTime': DateTime.now(),
      'isOpen': false
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountsProvider>(context).account!;
    final myOrders = Provider.of<OrdersProvider>(context);
    var orderList = myOrders.myPendingOrders(user.id!);
    return Container(
      child: ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 140,
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    shadowColor: Colors.white,
                    color: bgColor,
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          // Flexible(
                          //   child: Container(),
                          //   flex: 1,
                          // ),
                          Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderList[index].paymentType == 1
                                        ? "Cash"
                                        : orderList[index].paymentType == 2
                                            ? "Credit Card"
                                            : "Camel Wallet",
                                    style: listFont,
                                  ),
                                  Text(
                                    "Prdouct type: " + orderList[index].objType,
                                    style: listFont,
                                  ),
                                  Text(
                                    "Pickup: ",
                                    style: listFont,
                                  ),
                                  Text(
                                    "Drop: ",
                                    style: listFont,
                                  )
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Text(
                                    "Bill: \$" +
                                        orderList[index].bill.toString(),
                                    style: listFont,
                                  )),
                                  Expanded(
                                      child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () => _acceptOrder(
                                              orderList[index].id,
                                              orderList[index].clientId,
                                              orderList[index].companyId),
                                          icon: const Icon(
                                            Icons.done_outline_rounded,
                                            color: Colors.green,
                                          )),
                                      IconButton(
                                          onPressed: () => _rejectOrder(
                                              orderList[index].id,
                                              orderList[index].clientId,
                                              orderList[index].companyId),
                                          icon: const Icon(
                                            Icons.delete_forever_outlined,
                                            color: Colors.red,
                                          )),
                                    ],
                                  )),
                                  Expanded(
                                      child: Text(
                                    DateFormat.yMEd()
                                        .format(orderList[index].date),
                                    style: hintFont,
                                  ))
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.grey.shade600,
                thickness: 1,
              )
            ],
          );
        },
      ),
    );
  }
}
