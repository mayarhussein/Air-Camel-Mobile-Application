import 'package:air_camel/constants.dart';
import 'package:air_camel/models/drawer/offer.dart';
import 'package:air_camel/pages/launch_app/splash_screen.dart';
import 'package:air_camel/providers/offers_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/account.dart';
import '../../providers/companies_provider.dart';

class OffersScreen extends StatefulWidget {
  static const routeName = '/offers';

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  Widget build(BuildContext context) {
    CollectionReference offersData =
        FirebaseFirestore.instance.collection('offers');

    List<Account> companyList =
        Provider.of<CompaniesProvider>(context, listen: false).companiesList;

    return ChangeNotifierProvider(
      create: (_) => OffersProvider(),
      child: StreamBuilder<QuerySnapshot>(
          stream: offersData.snapshots(),
          builder: (ctx, offersSanpshot) {
            if (offersSanpshot.data == null) {
              return SplashScreen();
            }
            List<OfferModel> offersList = offersSanpshot.data!.docs.map((item) {
              Timestamp stamp1 = item['dateTime'];
              Timestamp stamp2 = item['expireTime'];
              return OfferModel(
                  id: item['id'],
                  idCompany: item['idCompany'],
                  dateTime: DateTime.parse(stamp1.toDate().toString()),
                  expireTime: DateTime.parse(stamp2.toDate().toString()),
                  offerMsg: item['offerMsg']);
            }).toList();
            Provider.of<OffersProvider>(ctx).setOffers(offersList);
            final offersData = Provider.of<OffersProvider>(ctx);

            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Offers",
                    style: headFont1,
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  backgroundColor: bgColor,
                  elevation: 0,
                  shadowColor: Colors.white,
                ),
                body: Container(
                  decoration: BoxDecoration(color: bgColor),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: ListView.builder(
                      itemCount: offersData.offers.length,
                      itemBuilder: (context, index) {
                        //final theCompany = companyList.firstWhere((item) =>
                            //item.id == offersData.offers[index].idCompany);

                        // print(companyList.first.id);
                        // print(companyList.last.id);
                        // print(theCompany);

                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 100,
                              child: InkWell(
                                onTap: () {},
                                child: Card(
                                  shadowColor: Colors.white,
                                  color: bgColor,
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
                                                const Icon(Icons.card_giftcard),
                                                Text(
                                                  '',
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
                                                  offersData
                                                      .offers[index].offerMsg,
                                                  style: GoogleFonts.fredokaOne(
                                                      fontSize: 15),
                                                ),
                                                const SizedBox(height: 20),
                                                Text('valid from ' +
                                                    DateFormat.yMd().format(
                                                        offersData.offers[index]
                                                            .dateTime) +
                                                    ' thru ' +
                                                    DateFormat.yMd().format(
                                                        offersData.offers[index]
                                                            .expireTime))
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
                ));
          }),
    );
  }
}
