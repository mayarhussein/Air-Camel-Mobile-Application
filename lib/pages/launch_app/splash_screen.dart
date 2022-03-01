import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  int duration = 0;
  final String goToPage;
  SplashScreen(this.duration,this.goToPage);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: this.duration), () {
      Navigator.of(context).pushNamed(this.goToPage);
    });

    return Material(
        child: Container(
            color: Colors.blueGrey,
            alignment: Alignment.center,
            child: Stack(
              children: [
                Align(
                  child: Icon(Icons.accessibility, size: 80),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      strokeWidth: 10,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white.withOpacity(0.5)),
                    ),
                  ),
                )
              ],
            )));
  }
}
