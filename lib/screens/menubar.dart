import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';


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
            Image(image: AssetImage('assets/image/logo.png'),
            fit: BoxFit.scaleDown,
            )
            ),
            decoration: BoxDecoration(
                color: Color(0xffffe6e6),
               /* image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image/bgtrans1.png'),
                    colorFilter: ColorFilter.mode(
                        Color(0xffe64241).withOpacity(0.7),
                        BlendMode.darken
                    )
                    )*/
                )
                    ),

          ListTile(
            leading: Icon(Icons.input),
            title: Text('Dashboard'),
            onTap: () => {
              if(isCurrent != '/')
                 Navigator.of(context).popUntil(ModalRoute.withName('/'))
                // Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false)
              else
                Navigator.pop(context)
            },
          ),
          ListTile(
            leading: Icon(Icons.add_location_sharp),
            title: Text('Tracking'),
            onTap: () => {
              if(isCurrent == '/')
              Navigator.pushNamed(context, '/tracking')
            else if(isCurrent == '/tracking')
              Navigator.pop(context)
              else
                {

                  Navigator.pushReplacementNamed(context, '/tracking')
                }
         },
    ),
          ListTile(
            leading: Icon(Icons.business_center),
            title: Text('About Us'),
            onTap: () => { if(isCurrent == '/')
                Navigator.pushNamed(context, '/aboutus')
               else if(isCurrent == '/aboutus')
                Navigator.pop(context)
               else
                Navigator.pushReplacementNamed(context, '/aboutus')
    }
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () =>
            { if(isCurrent == '/')
              Navigator.pushNamed(context, '/feedback')
            else
              if(isCurrent == '/feedback')
                Navigator.pop(context)
              else
                Navigator.pushReplacementNamed(context, '/feedback')
            }),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => { if(isCurrent == '/')
              Navigator.pushNamed(context, '/settings')
            else if(isCurrent == '/settings')
                Navigator.pop(context)
              else
                Navigator.pushReplacementNamed(context, '/settings')},
          ),
        ],
      ),
    );
  }
}