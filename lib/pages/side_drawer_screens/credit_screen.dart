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
        backgroundColor: Colors.amber.shade100,
        elevation: 0,
        shadowColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.amber.shade100),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              width: double.infinity,
              child: SizedBox(
                height: 700,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Card(
                        semanticContainer: true,
                        elevation: 6,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/credit_background.png'),
                                  fit: BoxFit.fill)),
                          child: Column(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  "Credit",
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 40, bottom: 35),
                                child: Text("Amount 73.20 EGP"),
                              )
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 30, right: 10, left: 10, bottom: 20),
                      child: Text(
                        "Payments history",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      height: 400,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 2,
                            color: Colors.amber.shade100.withOpacity(0.9),
                            child: Container(
                              width: double.maxFinite * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Company Name",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          "Amount: " +
                                              Payment.paymentList[index].amount
                                                  .toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Date: " +
                                            DateFormat.yMMMd().format(Payment
                                                .paymentList[index].dateTime)),
                                        Row(
                                          children: [
                                            TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "View",
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                )),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.report_problem,
                                                  color: Colors.red,
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: Payment.paymentList.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
