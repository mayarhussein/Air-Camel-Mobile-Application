import 'package:air_camel/constants.dart';
import 'package:air_camel/models/drawer/featured_offer.dart';
import 'package:air_camel/providers/offers_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientHomeOffers extends StatelessWidget {
  const ClientHomeOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final featuredOffersList =
        Provider.of<OffersProvider>(context).getFeaturedOffers();
    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        itemCount: featuredOffersList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Card(
            color: bgColor,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.white10,
                Colors.teal,
                Colors.blueGrey,
              ], begin: Alignment.topLeft)),
              padding: mainPadding,
              width: MediaQuery.of(context).size.width * 0.65,
              child: Text(
                featuredOffersList[index].offerMsg,
                style: subTitle2,
              ),
            ),
          );
        },
      ),
    );
  }
}
