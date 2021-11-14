import 'package:flutter/material.dart';
import 'layout.dart';
import 'menubar.dart';
class service extends StatefulWidget {
  @override
  _serviceState createState() => _serviceState();
}

class _serviceState extends State<service> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(route: '/claim',),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Service Locations"),
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
