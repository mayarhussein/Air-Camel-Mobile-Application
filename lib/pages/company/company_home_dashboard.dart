import 'package:air_camel/constants.dart';
import 'package:air_camel/models/orders.dart';
import 'package:air_camel/pages/company/edit_categories.dart';
import 'package:air_camel/pages/company/payment_history.dart';
import 'package:air_camel/widgets/company/company_home_btn.dart';
import 'package:air_camel/widgets/company/shipments_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:air_camel/pages/company/complaints_screen.dart';

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
                    "Show Complanits",
                    ComplaintsScreen.routeName,
                    Colors.red.shade100,
                    Colors.red.shade900,
                    Icons.error_outline_outlined),
                CompanyHomeBtn("New Offer", PayementsHistory.routeName,
                    Colors.pink.shade100, Colors.pink.shade900, Icons.add)
              ],
            ),
          ),
          // CompanyHomeBtn("Show Complanits", ComplaintsScreen.routeName),
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
                    child: ShipmentsList(),
                  ),
                ],
              ),
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
