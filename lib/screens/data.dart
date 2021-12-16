import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'menubar.dart';
import 'package:mrtc/services.dart';
import 'package:mrtc/screens/modal.dart';
import 'package:http/http.dart' as http;

Future<dynamic> getstates() async {
    var state;
    var states = await fetchstates();
    print(states);
    if(states == "Try again")
      return state;
    var st = states.body;
    var s = jsonDecode(st);
    print(s);
    return s;
}

Future<dynamic> getcentres(String id) async {
    var centre;
    var centres = await fetchcentres(id);
    if(centres == "Try again")
        return centre;
    var ct = centres.body;
    centres = jsonDecode(ct);
    return centres;
}
Future<bool> hasNetwork() async {
    try {
        final result = await InternetAddress.lookup('example.com');
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
        return false;
    }
}
 /* List<String> listsgenerate()
  {
    List<String> state = ['Select State'];
    var d = getstates();
    for(int i = 0;i<d.length;i++)
      {
        state[i+1] = d[i];
      }
    return state;
  }*/
