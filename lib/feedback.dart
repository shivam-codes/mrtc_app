import 'package:flutter/material.dart';
import 'layout.dart';
import 'menubar.dart';
class feedback extends StatefulWidget {
  @override
  _feedbackState createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(route: '/feedback',),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Feedback"),
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
