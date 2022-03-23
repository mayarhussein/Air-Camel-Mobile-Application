import 'package:air_camel/constants.dart';
import 'package:air_camel/models/complaints.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ComplaintsScreen extends StatelessWidget {
  static const routeName = '/complaints';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Complaints",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: bgColor,
        ),
        body: Container(
          color: bgColor,
          child: ListView.builder(
            itemCount: ComplaintsModel.dummy_complaints.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
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
                                      Row(
                                        children: [
                                          const Icon(Icons.person),
                                          Text(
                                            ComplaintsModel
                                                .dummy_complaints[index]
                                                .clientName,
                                            style: GoogleFonts.fredokaOne(
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
                                      Text(
                                        DateFormat.yMd().format(ComplaintsModel
                                            .dummy_complaints[index].date),
                                        style:
                                            GoogleFonts.righteous(fontSize: 14),
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
                                        ComplaintsModel
                                            .dummy_complaints[index].body,
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
        ));
  }
}
