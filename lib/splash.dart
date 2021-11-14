import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'layout.dart';
import 'dart:async';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => Navigator.of(context).pushReplacementNamed('/'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffFFA3A3), Color(0xffFFE4E4)]
            )
          ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/image/logo.png',),
          SizedBox(
            height: 20,
          ),
          Text('Welcome', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
          //SizedBox(
           // height: 50,
          //),
          //Padding(
            //padding: EdgeInsets.only(top: 150),
            //child: Text('Made by \n INFINITY', style: TextStyle(fontSize: 12, color: Color(0xff727272), fontFamily: 'OpenSans'),))
          //]),
      ]),
      )
      )
    );
  }
}
