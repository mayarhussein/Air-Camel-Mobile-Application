import 'package:air_camel/constants.dart';
import 'package:flutter/material.dart';

class ClientHomeExplore extends StatelessWidget {
  const ClientHomeExplore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: mainPadding,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.grey.shade600,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.height * 0.2,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      bgColor,
                      Colors.lightBlue.shade800,
                    ], end: Alignment.topLeft, begin: Alignment.bottomRight)),
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text("Ship through\nAir.", style: btnFont2),
                          ],
                        ),
                        Image(
                          image: AssetImage("assets/images/ship_airline.png"),
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.12,
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
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      bgColor,
                      Colors.lightGreen.shade800,
                    ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text("Or Go\nOverseas.", style: btnFont2),
                          ],
                        ),
                        Image(
                          image: AssetImage("assets/images/ship_overseas.png"),
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.12,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.grey.shade600,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      bgColor,
                      Colors.red.shade400,
                    ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(" Inside.   ", style: btnFont2),
                          ],
                        ),
                        Image(
                          image: AssetImage("assets/images/local_ship.png"),
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.12,
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
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      bgColor,
                      Colors.purple.shade400,
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text("Or Going\nAbroad.", style: btnFont2),
                          ],
                        ),
                        Image(
                          image: AssetImage("assets/images/global_ship.png"),
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.12,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
