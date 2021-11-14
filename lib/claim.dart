import 'package:flutter/material.dart';
import 'layout.dart';
import 'menubar.dart';
class claim extends StatefulWidget {
  @override
  _claimState createState() => _claimState();
}

class _claimState extends State<claim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(route: '/claim',),
    appBar: AppBar(
    centerTitle: true,
    title: Text("Claim"),
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
