import 'package:flutter/material.dart';
import '../pages/welcome_screen.dart';

class MyButton extends StatelessWidget {
  final String title;
  final String screenRoute;
  final Role? role;

  MyButton(this.title, this.screenRoute, this.role);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              splashColor: Colors.red.withOpacity(0.2),
              highlightColor: Colors.white.withOpacity(0.2),
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                      child: Text(title, style: TextStyle(color: Colors.white)),
                      onPressed: () => {
                            Navigator.of(context)
                                .pushNamed(screenRoute, arguments: role)
                          },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.amber.withOpacity(0.7),
                          side: const BorderSide(width: 3, color: Colors.amber),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding:
                              EdgeInsets.all(20) //content padding inside button
                          )))),
        ),
      ),
    );
  }
}
