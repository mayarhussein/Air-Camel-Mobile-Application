import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CompanyItem extends StatelessWidget {

 final String title;
 final String screenRoute;


  CompanyItem(this.title,this.screenRoute);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>{Navigator.of(context).pushNamed(screenRoute)} ,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.grey.shade600,
        child: SizedBox(
          height: 50,
          width: 170,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.cyan.shade100,
              Colors.cyan.shade900,
            ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.wysiwyg_rounded),
                Text(
                  title,
                  style: GoogleFonts.pacifico(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
