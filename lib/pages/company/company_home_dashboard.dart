import 'package:air_camel/constants.dart';
import 'package:air_camel/models/orders.dart';
import 'package:air_camel/pages/company/edit_categories.dart';
import 'package:air_camel/pages/company/new_offer_screen.dart';
import 'package:air_camel/pages/company/payment_history.dart';
import 'package:air_camel/pages/launch_app/splash_screen.dart';
import 'package:air_camel/providers/orders_provider.dart';
import 'package:air_camel/widgets/company/company_home_btn.dart';
import 'package:air_camel/widgets/company/shipments_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:air_camel/pages/company/company_complaints_screen.dart';
import 'package:provider/provider.dart';

final ordersCollection = FirebaseFirestore.instance.collection('orders');

class CompanyHomeDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myOrders = Provider.of<OrdersProvider>(context);

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
              style: headFont1,
            )),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CompanyHomeBtn(
                    "Edit Categories",
                    EditCategories.routeName,
                    Colors.cyan.shade100,
                    Colors.cyan.shade900,
                    Icons.mode_edit_outlined),
                CompanyHomeBtn(
                    "Shipment History",
                    PayementsHistory.routeName,
                    Colors.blue.shade100,
                    Colors.blue.shade900,
                    Icons.history_edu_rounded)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CompanyHomeBtn(
                    "Show Complaints",
                    CompanyComplaintsScreen.routeName,
                    Colors.red.shade100,
                    Colors.red.shade900,
                    Icons.error_outline_outlined),
                CompanyHomeBtn("New Offer", NewOfferScreen.routeName,
                    Colors.pink.shade100, Colors.pink.shade900, Icons.add)
              ],
            ),
          ),
          // CompanyHomeBtn("Show Complanits", CompanyComplaintsScreen.routeName),
          Card(
            // color: bgColor,
            margin: EdgeInsets.all(10),
            elevation: 9,
            child: Container(
              padding: EdgeInsets.all(10),
              height: 500,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text("Pending Requests:",
                        textAlign: TextAlign.start, style: subTitle1),
                  ),
                  Container(
                    height: 420,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: ordersCollection.snapshots(),
                      builder: (ctx, ordersSnapshot) {
                        if (ordersSnapshot.data == null) {
                          return SplashScreen();
                        }
                        List<OrdersModel> ordersList =
                            ordersSnapshot.data!.docs.map((item) {
                          return OrdersModel(
                              objType: item['objType'],
                              bill: (item['bill'] as int).toDouble(),
                              clientId: item['clientId'],
                              companyId: item['companyId'],
                              date: (item['date'] as Timestamp).toDate(),
                              from: item['from'],
                              paymentType: item['paymentType'],
                              status: item['status'],
                              to: item['to'],
                              dimensions: item['dimensions'],
                              id: item['id'],
                              other: item['other'],
                              rating: item['rating'],
                              weight: item['weight']);
                        }).toList();
                        myOrders.setOrder(ordersList);
                        return ShipmentsList();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              // itemCount: FeaturedOfferModel.featuredOffersList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Card(
                  color: bgColor,
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
