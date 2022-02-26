import 'package:air_camel/constants.dart';
import 'package:air_camel/resources/app_theme.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  static const routeName = '/help';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.amber.shade100),

      // color: Colors.white,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'How can we help you?',
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
          body: Container(
            decoration: BoxDecoration(color: Colors.amber.shade100),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top * 0.2,
                      left: 16,
                      right: 16),
                  child: Image.asset('assets/images/helpImage.png'),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'It looks like you are experiencing some \nproblems.We are here to help so please \nget in touch with us',
                    textAlign: TextAlign.center,
                    style: defaultFont1,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        width: 160,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.transparent,
                                offset: Offset(4, 4),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.red.shade400,
                          child: InkWell(
                            onTap: () {},
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Send Us A Message',
                                  style: btnFont1,
                                ),
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
