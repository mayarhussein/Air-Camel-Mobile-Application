import 'package:air_camel/models/drawer/featured_offer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: double.infinity,
          height: 700,
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
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
                          height: 150,
                          width: 150,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Colors.amber.shade100,
                                  Colors.lightBlue.shade800,
                                ],
                                    end: Alignment.topLeft,
                                    begin: Alignment.bottomRight)),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text("Ship through\nAir.",
                                        style:
                                            GoogleFonts.pacifico(fontSize: 15)),
                                  ],
                                ),
                                Image(
                                  image: AssetImage(
                                      "assets/images/ship_airline.png"),
                                  height: 50,
                                  width: 50,
                                )
                              ],
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
                          height: 150,
                          width: 150,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Colors.amber.shade100,
                                  Colors.lightGreen.shade800,
                                ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight)),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text("Or Go\nOverseas.",
                                        style:
                                            GoogleFonts.pacifico(fontSize: 15)),
                                  ],
                                ),
                                Image(
                                  image: AssetImage(
                                      "assets/images/ship_overseas.png"),
                                  height: 50,
                                  width: 50,
                                )
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
                          height: 150,
                          width: 150,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Colors.amber.shade100,
                                  Colors.red.shade400,
                                ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft)),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(" Inside.   ",
                                        style:
                                            GoogleFonts.pacifico(fontSize: 15)),
                                  ],
                                ),
                                Image(
                                  image: AssetImage(
                                      "assets/images/local_ship.png"),
                                  height: 50,
                                  width: 50,
                                )
                              ],
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
                          height: 150,
                          width: 150,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Colors.amber.shade100,
                                  Colors.purple.shade400,
                                ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight)),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text("Or Going\nAbroad.",
                                        style:
                                            GoogleFonts.pacifico(fontSize: 15)),
                                  ],
                                ),
                                Image(
                                  image: AssetImage(
                                      "assets/images/global_ship.png"),
                                  height: 50,
                                  width: 50,
                                )
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
                height: 200,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                  itemCount: FeaturedOffer.featuredOffersList.length,
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
                        child: Text(
                          FeaturedOffer.featuredOffersList[index].offerMsg,
                          style: GoogleFonts.lobster(fontSize: 25),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
