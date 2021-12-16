import 'dart:convert';
import 'package:advanced_datatable/datatable.dart';
import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:flutter/cupertino.dart';
import 'data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'menubar.dart';
import 'package:mrtc/services.dart';
import 'package:advanced_datatable/advanced_datatable.dart';

class service extends StatefulWidget {
  @override
  _serviceState createState() => _serviceState();
}

class _serviceState extends State<service> {
  String value = "Select State";
  var st;
  int count = 0;
  var statecode = 0;
  List<String> state = ['Select State'];
  var list = {};
  List<Map> _centres = [];
  bool isonline = true;
  var fontbig = 17.0;
  var fontsma = 14.0;
  void check() async {
    isonline = await hasNetwork();
  }
  void initState()  {
    check();
    iniState();
    super.initState();
  }
  void iniState() async
  {
    var states = await getstates();
    setState(() {
      st = states;
    });
    print("Here");
    print(st);
    for (int i = 0; i < st.length; i++) {
      state.add(st[i][1]);
      list[st[i][1]] = st[i][0];
    }
    print(list);
    print(state);
  }

  void centres() async
  {
    _centres.clear();
    var centre = await getcentres(statecode.toString());
    var cr;
    setState(() {
      cr = centre;
    });
    for (int i = 0; i < cr.length; i++) {
      var c = {};
      c['city'] = cr[i][2].toString();
      c['phone'] = cr[i][5].toString();
      c['mail'] = cr[i][7].toString();
      c['booking'] = cr[i][3].toString();
      c['delivery'] = cr[i][4].toString();
      c['manager'] = cr[i][8].toString();
      c['address'] = cr[i][14].toString();
      c['pin'] = cr[i][13].toString();
      _centres.add(c);
    }
    print(_centres);
  }

  int _currentSortCoulmn = 0;
  bool _isSortasc = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
        drawer: NavDrawer(route: '/service',),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Service Locations"),
        ),
        body: Center(
            child: Stack(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.15),
                        child: value != "Select State" ? Text(
                          "Centres", textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[400],
                              decorationThickness: 1.5),) : Text(""),),
                        value == "Select State" ? Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.04, left: width / 2.8),
                            child: Text("Select a State", style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                              textAlign: TextAlign.center,)) :
                        Flexible(child: Padding(padding: EdgeInsets.only(
                            left: width * 0.02, right: width * 0.02, top: 10),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int i) {
                              return new ExpansionTile(
                                textColor: Colors.white,
                                collapsedTextColor: Colors.black,
                                iconColor: Colors.white,
                                //tilePadding: EdgeInsets.symmetric(vertical: 10),
                                collapsedBackgroundColor: Color(0xffffe6e6)
                                    .withOpacity(0.4),
                                backgroundColor: Colors.red[400],
                                childrenPadding: EdgeInsets.only(
                                    left: width * 0.07,
                                    right: width * 0.07,
                                    bottom: height * 0.01),
                                title: Text(_centres[i]['city'],
                                    style: new TextStyle(fontSize: fontbig,
                                        fontWeight: FontWeight.w500)),
                                children: <Widget>[
                                       Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        (_centres[i]['manager'] != '') ? Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              Text('Manager:  ', style: TextStyle(
                                                  fontSize: fontsma,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),),
                                              Text(_centres[i]['manager'],
                                                  style: TextStyle(
                                                    fontSize: fontsma,
                                                    fontWeight: FontWeight
                                                        .normal,
                                                    color: Colors.white,)),
                                            ]
                                        ):Padding(padding:EdgeInsets.all(0)),
                                                  Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              Text('Phone:  ', style: TextStyle(
                                                  fontSize: fontsma,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),),
                                              Text(_centres[i]['phone'],
                                                  style: TextStyle(
                                                    fontSize: fontsma,
                                                    fontWeight: FontWeight
                                                        .normal,
                                                    color: Colors.white,)),
                                            ]
                                        ),
                                        _centres[i]['mail'] != '' ? Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              Text('Mail:  ', style: TextStyle(
                                                  fontSize: fontsma,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),),
                                              Text(_centres[i]['mail'],
                                                  style: TextStyle(
                                                    fontSize: fontsma,
                                                    fontWeight: FontWeight
                                                        .normal,
                                                    color: Colors.white,)),
                                            ]
                                        ):Padding(padding:EdgeInsets.all(0)),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              Text('Type:  ', style: TextStyle(
                                                  fontSize: fontsma,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),),
                                              Text(_centres[i]['booking'] ==
                                                  'Yes'
                                                  ? "Booking"
                                                  : _centres[i]['delivery'] ==
                                                  'Yes' ? "Delivery" : "None",
                                                  style: TextStyle(
                                                    fontSize: fontsma,
                                                    fontWeight: FontWeight
                                                        .normal,
                                                    color: Colors.white,)),
                                            ]
                                        ),
                                        _centres[i]['address'] != '' ? Container(
                                           width: width*0.8,
                                           child:Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('Address:  ', style: TextStyle(
                                                  fontSize: fontsma,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                             ),
                                              Expanded(

                                                  child:Text(_centres[i]['address'],

                                                  style: TextStyle(
                                                    fontSize: fontsma,
                                                    fontWeight: FontWeight
                                                        .normal,
                                                    color: Colors.white,),
                                             overflow: TextOverflow.fade ,),)


                                            ])
                                        ):Padding(padding:EdgeInsets.all(0)),
                                        _centres[i]['pin'] != '' ? Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              Text('Pin:  ', style: TextStyle(
                                                  fontSize: fontsma,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),),
                                              Text(_centres[i]['pin'],
                                                  style: TextStyle(
                                                    fontSize: fontsma,
                                                    fontWeight: FontWeight
                                                        .normal,
                                                    color: Colors.white,)),
                                            ]
                                        ):Padding(padding:EdgeInsets.all(0))
                                      ])

                                   ],
                                   );
                            },
                            itemCount: _centres.length,
                          ),
                        ),

                        )]
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.5)
                                ),
                                contentPadding: EdgeInsets.fromLTRB(
                                    10, 10, 10, 10),
                                filled: true,
                                fillColor: Color(0xffffe6e6)
                            ),
                            dropdownColor: Color(0xffffe6e6),
                            value: value,
                            icon: const Icon(Icons.arrow_drop_down_outlined),
                            iconSize: 24,
                            elevation: 15,
                            //isExpanded: true,
                            //borderRadius: BorderRadius.circular(10),

                            style: GoogleFonts.openSans(textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                            onChanged: (String? newValue) {
                              setState(() {
                                value = newValue!;
                              });
                              if (isonline == false) {
                                final snackbar = SnackBar(
                                    content: Text('No Internet Connection. Try Again!'));
                                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                              }
                              else {
                                if (value != 'Select State') {
                                  setState(() {
                                    statecode = list[value];
                                    print(statecode);
                                  });
                                  centres();
                                }
                              }
                            },
                            items: state.map<DropdownMenuItem<String>>((
                                String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                      ),
                    ]),


              ],
            )
        )
    );
  }
}
