import 'package:flutter/material.dart';
import 'layout.dart';
import 'menubar.dart';
class complain extends StatefulWidget {
  @override
  _complainState createState() => _complainState();
}

class _complainState extends State<complain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(route: '/claim',),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Complaint"),
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
