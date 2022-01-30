import 'package:air_camel/models/orders.dart';
import 'package:air_camel/pages/company/edit_categories.dart';
import 'package:air_camel/pages/company/payment_history.dart';
import 'package:air_camel/widgets/company/home_item.dart';
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
                CompanyItem("Edit Categories", EditCategories.routeName),
                CompanyItem("Shipment History", PayementsHistory.routeName)
              ],
            ),
          ),
          CompanyItem(
            "Show Complanits", ComplaintsScreen.routeName
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: 500,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text("Pending Requestes:",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.fredokaOne(fontSize: 20)),
                ),
                Container(
                  height: 400,
                  child: ShipmentsList(),
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
