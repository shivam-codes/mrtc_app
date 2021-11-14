import 'package:flutter/material.dart';
import 'menubar.dart';

class settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(route: '/settings',),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Settings"),
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
