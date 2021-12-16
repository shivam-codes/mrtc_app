import 'package:flutter/material.dart';
import 'menubar.dart';
class job extends StatefulWidget {
  @override
  _jobState createState() => _jobState();
}

class _jobState extends State<job> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(route: '/claim',),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Apply"),
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
