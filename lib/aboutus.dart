import 'package:flutter/material.dart';
import 'menubar.dart';

class aboutus extends StatefulWidget {
  @override
  _aboutusState createState() => _aboutusState();
}

class _aboutusState extends State<aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(route: '/aboutus',),
        appBar: AppBar(
          centerTitle: true,
          title: Text("About Us"),
        ),
        body: Center(
          child: Text('Page under \nconstruction', style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
        )
    );
  }
}
