import 'package:air_camel/constants.dart';
import 'package:air_camel/models/orders.dart';
import 'package:air_camel/widgets/company/shipments_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PayementsHistory extends StatelessWidget {
  static const routeName = '/payments-history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Shipments History",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: bgColor,
        ),
        body: Container(color: bgColor, child: ShipmentsList()));
  }
}
