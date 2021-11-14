import 'package:flutter/material.dart';
import 'menubar.dart';
import 'dashboard.dart';

class layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(route: '/',),
      appBar: AppBar(
        centerTitle: true,
        title: Text(''),
        actions: <Widget>[
          Image(image: AssetImage("assets/image/logo.png"),
            height: 55,)
        ],
      ),
     body: Dashboard()
    );
  }
}

