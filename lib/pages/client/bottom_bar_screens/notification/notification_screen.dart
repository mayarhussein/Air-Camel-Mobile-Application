import 'package:air_camel/constants.dart';
import 'package:air_camel/models/notification.dart';
import 'package:air_camel/providers/notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final notificationsData = Provider.of<NotificationsProvider>(context);

    return Container(
      width: double.infinity,
      padding: mainPadding,
      // color: bgColor,
      // decoration: BoxDecoration(color: bgColor),
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.12,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Notifications",
                style: headFont1,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.74,
            child: ListView.builder(
              itemCount: notificationsData.notifications.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            notificationsData.notifications[index].isOpen =
                                true;
                          });
                        },
                        child: Card(
                          shadowColor: bgColor,
                          color: notificationsData.notifications[index].isOpen
                              ? Colors.white
                              : bgColor,
                          elevation: 5,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding: EdgeInsets.all(10),
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
                                              notificationsData
                                                  .notifications[index]
                                                  .dateTime),
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
                                          notificationsData
                                              .notifications[index].message,
                                          style: defaultFont1,
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
    );
  }
}
