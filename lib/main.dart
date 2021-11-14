import 'package:flutter/material.dart';
import 'package:mrtc/aboutus.dart';
import 'layout.dart';
import 'menubar.dart';
import 'tracking.dart';
import 'dashboard.dart';
import 'service.dart';
import 'job.dart';
import 'claim.dart';
import 'complain.dart';
import 'feedback.dart';
import 'splash.dart';
import 'settings.dart';
void main() {
  runApp(MyApp());
}
 class MyApp extends StatefulWidget {
   @override
   _MyAppState createState() => _MyAppState();
 }

 class _MyAppState extends State<MyApp> {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
        // builder: (context, child) => BaseWidget(child: child!),
         initialRoute: '/splash',
         routes: {
         '/' : (context) => layout(),
           '/tracking' : (context) => tracking(),
           '/service' : (context) => service(),
           '/claim' : (context) => claim(),
           '/complain' : (context) => complain(),
           '/feedback' : (context) => feedback(),
           '/job' : (context) => job(),
           '/splash' : (context) => splash(),
           '/aboutus' : (context) => aboutus(),
           '/settings' : (context) => settings(),
           '/feedback' : (context) => feedback(),
         },
         theme: ThemeData(
           primaryColor: Color(0xffffe6e6)
         ),
        // home: layout(),
     );
   }
 }
