import 'package:air_camel/constants.dart';
import 'package:air_camel/models/drawer/featured_offer.dart';
import 'package:air_camel/widgets/client/bottom_bar/home/client_home_explore.dart';
import 'package:air_camel/widgets/client/bottom_bar/home/client_home_offers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: mainPadding,
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.12,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Explore",
                style: headFont1,
              ),
            ),
          ),
          ClientHomeExplore(),
          ClientHomeOffers()
        ],
      ),
    );
  }
}
