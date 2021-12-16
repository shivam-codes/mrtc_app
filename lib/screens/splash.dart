import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
   super.initState();
   _navigatedash();
  }
  _navigatedash() async {
    await Future.delayed(Duration(milliseconds: 1500),() {});
    //Navigator.pushReplacementNamed(context,'/');
    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffFFA3A3), Color(0xffFFE4E4)]
          )
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/image/logo.png', width: size.width*0.7,),
          SizedBox(
            height: 20,
          ),
        //  Text('WELCOME', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 2.0, color: Colors.black, textBaseline: null),),
          //SizedBox(
           // height: 50,
          //),
          //Padding(
            //padding: EdgeInsets.only(top: 150),
            //child: Text('Made by \n INFINITY', style: TextStyle(fontSize: 12, color: Color(0xff727272), fontFamily: 'OpenSans'),))
          //]),
      ]),
      );

  }
}
