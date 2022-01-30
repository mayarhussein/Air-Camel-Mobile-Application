import 'package:air_camel/models/orders.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ShipmentsList extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
     return Container(
      child: ListView.builder(
        itemCount: OrdersModel.dummy_orders.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    shadowColor: Colors.white,
                    color: Colors.amber.shade100,
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      child: Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.notifications_active),
                                  Text(
                                    DateFormat.yMd().format(
                                        OrdersModel.dummy_orders[index].date),
                                    style: GoogleFonts.righteous(fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                            flex: 2,
                          ),
                          Flexible(
                            child: Container(),
                            flex: 1,
                          ),
                          Flexible(
                              flex: 3,
                              child: Column(
                                children: [
                                  Text(
                                    OrdersModel.dummy_orders[index].paymentType,
                                    style: GoogleFonts.fredokaOne(fontSize: 15),
                                  )
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
