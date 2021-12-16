import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/aboutus.dart';
import 'screens/menubar.dart';
import 'screens/tracking.dart';
import 'screens/dashboard.dart';
import 'screens/service.dart';
import 'screens/job.dart';
import 'screens/claim.dart';
import 'screens/complain.dart';
import 'screens/feedback.dart';
import 'screens/splash.dart';
import 'screens/settings.dart';
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
         //builder: (context, child) => BaseWidget(child: child!),
         initialRoute: '/splash',
         routes: {
         '/' : (context) => Dashboard(),
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
           primaryColor: Color(0xffffe6e6),
         ),
     );
   }
 }

