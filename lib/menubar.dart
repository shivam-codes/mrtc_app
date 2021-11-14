//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:google_fonts/google_fonts.dart';

class NavDrawer extends StatelessWidget {
  final String route;
  const NavDrawer({
    Key? key,
    required this.route,
}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var isCurrent = route;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(child:
             Text(
              '',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )
              ),
             )
            ),
            decoration: BoxDecoration(
                color: Color(0xffffe6e6),
                image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: AssetImage('assets/image/logo.png'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Dashboard'),
            onTap: () => {
              if(isCurrent != '/')
                Navigator.pushNamed(context, '/')
              else
                Navigator.pop(context)
            },
          ),
          ListTile(
            leading: Icon(Icons.add_location_sharp),
            title: Text('Tracking'),
            onTap: () => {
              if(isCurrent != '/tracking')
              Navigator.pushNamed(context, '/tracking')
            else
              Navigator.pop(context)

         },
    ),
          ListTile(
            leading: Icon(Icons.business_center),
            title: Text('About Us'),
            onTap: () => { if(isCurrent != '/aboutus')
              Navigator.pushNamed(context, '/aboutus')
            else
              Navigator.pop(context)},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => { if(isCurrent != '/feedback')
              Navigator.pushNamed(context, '/feedback')
            else
              Navigator.pop(context)},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => { if(isCurrent != '/settings')
              Navigator.pushNamed(context, '/settings')
            else
              Navigator.pop(context)},
          ),
        ],
      ),
    );
  }
}