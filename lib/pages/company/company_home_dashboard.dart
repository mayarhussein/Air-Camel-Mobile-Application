import 'package:air_camel/models/orders.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CompanyHomeDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 15,
          ),
          SizedBox(
            width: double.maxFinite,
            height: 40,
            child: Center(
                child: Text(
              "Home",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.grey.shade600,
                    child: SizedBox(
                      height: 50,
                      width: 170,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Colors.cyan.shade100,
                              Colors.cyan.shade900,
                            ],
                                end: Alignment.topLeft,
                                begin: Alignment.bottomRight)),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Edit Categories",
                          style: GoogleFonts.pacifico(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.grey.shade600,
                    child: SizedBox(
                      height: 50,
                      width: 170,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Colors.cyan.shade100,
                              Colors.cyan.shade900,
                            ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight)),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.wysiwyg_rounded),
                            Text(
                              "Shipments History",
                              style: GoogleFonts.pacifico(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: 500,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    "Pending requestes",
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  height: 400,
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
                                                    OrdersModel
                                                        .dummy_orders[index]
                                                        .date),
                                                style: GoogleFonts.righteous(
                                                    fontSize: 14),
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
                                                OrdersModel.dummy_orders[index]
                                                    .paymentType,
                                                style: GoogleFonts.fredokaOne(
                                                    fontSize: 15),
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
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              // itemCount: FeaturedOffer.featuredOffersList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.amber.shade100,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.white10,
                      Colors.teal,
                      Colors.blueGrey,
                    ], begin: Alignment.topLeft)),
                    padding: EdgeInsets.all(15),
                    width: 250,
                    // child: Text(
                    //   FeaturedOffer.featuredOffersList[index].offerMsg,
                    //   style: GoogleFonts.lobster(fontSize: 25),
                    // ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
