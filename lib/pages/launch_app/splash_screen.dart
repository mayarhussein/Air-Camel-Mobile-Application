import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  int duration = 0;
  //final String goToPage;
  //SplashScreen(this.duration,this.goToPage);

  @override
  Widget build(BuildContext context) {
    //Future.delayed(Duration(seconds: this.duration), () {
      //Navigator.of(context).pushNamed(this.goToPage);
    //});

    return Material(
        child: Container(
           decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/gold.jpg"),
                 fit: BoxFit.cover,
                   )),           
            alignment: Alignment.center,
            child: Stack(
              children: [
                Center(
                  child: Container(
                      width: 150,
                      height: 150,
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.fill,
                      )),
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
