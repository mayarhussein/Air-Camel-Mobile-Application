import 'package:air_camel/constants.dart';
import 'package:air_camel/models/drawer/notification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: headFont1,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: bgColor,
        elevation: 0,
        shadowColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.amber.shade100),
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: NotificationModel.dummy_notifications.length,
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
                                            NotificationModel
                                                .dummy_notifications[index]
                                                .dateTime),
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
                                        NotificationModel
                                            .dummy_notifications[index].message,
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
      ),
    );
  }
}
