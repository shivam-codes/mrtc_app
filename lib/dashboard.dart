import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'menubar.dart';
import 'grid.dart';
//import 'menu_layout.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey _scaffoldkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Color(0xffeaeaea),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              height: size.height*.3,
              decoration: BoxDecoration(
                color: Color(0xffe64241),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15),),
              ),
              child:Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left:16, right:16, top:size.height*.075),
              child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

              /*  InkWell(
                  child: Icon(
                    Icons.menu, color: Colors.white,
                  ),
                  onTap: () {
                    setState(() {

                    });
                  },
                ),
              // Image(image: AssetImage("assets/image/logo.png"),
                //  height: 55,)*/
              ],
            ),
                ),
           Text(
               "Dashboard",
             style: GoogleFonts.openSans(
               textStyle:TextStyle(
               color: Colors.black,
                 fontSize: size.width*0.07,
                 fontWeight: FontWeight.bold,
             ),
           )
           ),

         ] ),
    ),
          ),
          //grid(),


       Padding(
           padding: EdgeInsets.only(top:0),
           child: grid(),
       ),
    ]
      )
    );
  }
}
