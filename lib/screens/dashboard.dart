import 'package:double_back_to_close_app/double_back_to_close_app.dart';
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
  final _scaffoldkey = new GlobalKey<ScaffoldState>();
  DateTime pre_backpres = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
          if(_scaffoldkey.currentState!.isDrawerOpen)
            {
              Navigator.of(context).pop();
              return false;
            }
          final timegap = DateTime.now().difference(pre_backpres);
          final cantexit = timegap >= Duration(seconds: 2);
          pre_backpres = DateTime.now();
          if(cantexit) {
            final snack = SnackBar(
              content: Text('Press Back button again to Exit'),
              duration: Duration(seconds: 2),);
            ScaffoldMessenger.of(context).showSnackBar(snack);
            return false;
          }else{
            return true;
          }
        },
        child: Scaffold(
            key: _scaffoldkey,
        drawer: NavDrawer(route: '/',),
        appBar: AppBar(
          centerTitle: true,
          title: Text(''),
          actions: <Widget>[
            Image(image: AssetImage("assets/image/logo.png"),
              height: 55,)
          ],
        ),
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
                image: DecorationImage(
                    image: AssetImage('assets/image/bgtrans2.jpg'),
                    fit: BoxFit.cover,
                   colorFilter: ColorFilter.mode(
                       Color(0xffe64241).withOpacity(0.7),
                       BlendMode.darken
                   )
                )
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
               color: Colors.white,
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
      ) );
  }
}
