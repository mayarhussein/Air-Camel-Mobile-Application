import 'package:air_camel/models/drawer/payments.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreditScreen extends StatelessWidget {
  static const routeName = '/credit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Card(
                elevation: 6,
                child: Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Credit",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 25, bottom: 35),
                      child: Text("Credit amount"),
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.all(4), child: Text("Payments history")),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                height: 200,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0,
                      color: Colors.white12,
                      child: Container(
                        child: Text("Amount: " +
                            Payment.paymentList[index].amount.toString() +
                            "Date: " +
                            DateFormat.yMMMd()
                                .format(Payment.paymentList[index].dateTime)),
                      ),
                    );
                  },
                  itemCount: Payment.paymentList.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
