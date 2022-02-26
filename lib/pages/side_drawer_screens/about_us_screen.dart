import 'package:air_camel/constants.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  static const routeName = '/aboutus';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'About Us',
              style: headFont1,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.amber.shade100,
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          backgroundColor: Colors.white,
          body: Container(
            decoration: BoxDecoration(color: Colors.amber.shade100),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Image.asset('assets/images/about_us.png'),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'Just a project for graduation for some students in Alexandria University',
                    textAlign: TextAlign.center,
                    style: defaultFont1,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.transparent,
                                offset: const Offset(4, 4),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.green.shade300,
                          child: InkWell(
                            onTap: () {
                              //method here for functionality
                              print('Share Action.');
                            },
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.contact_phone_rounded,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Contact Us',
                                      style: btnFont1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
