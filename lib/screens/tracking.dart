import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrtc/screens/data.dart';
import 'package:mrtc/services.dart';
import 'menubar.dart';
import 'dart:io';

class tracking extends StatefulWidget {
  @override
  _trackingState createState() => _trackingState();
}

class _trackingState extends State<tracking> {
  var route = '/tracking';
  String val = '';
  //String ans = 'Output';
  late List output;
  final _formkey = GlobalKey<FormState>();
  bool isonline = true;
  void check() async {
    isonline = await hasNetwork();
  }
  void initState() {
    check();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
          new TextEditingController().clear();
        },
        child:Scaffold(
      drawer: NavDrawer(route: route,),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Tracking"),
      ),
      body: Form(
         key: _formkey,
        child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        //mainAxisSize: Main,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 20, right: 20, top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Enter Consignment No.", style: GoogleFonts.openSans(textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,

                )),),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter here",
                     // errorText: "Try again"
                      //enabledBorder: ,
                  ),
                  validator: (value){
                    if(value == null || value.length == 0)
                      return 'Empty field not valid';
                          else if(value.length < 6 || value.length > 7)
                      return 'Enter valid consignment no.';
                    else
                      return null;
                  },
                  onChanged: (value) {
                    val = "http://103.91.90.200:8085/" + value.toString();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Center(child:
                ElevatedButton(onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    //print(val);
                    var data = await fetchdata(val);
                    print(data);
                    //var dat = data.body;
                    //print(dat);
                    //var d = jsonDecode(dat);
                    if (isonline == false) {
                      setState(() {
                        FocusScope.of(context).unfocus();
                      });
                      final snackbar = SnackBar(
                          content: Text('No Internet Connection. Try Again!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                    else {
                      var dat = data.body;
                      //print(dat);
                      var d = jsonDecode(dat);
                      setState(() {
                        output = d;
                        FocusScope.of(context).unfocus();
                        //ans = output[0][1].toString();
                      });
                      print(output.length);
                      if (output.length != 0) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog(context, output),
                        );
                      }
                      else
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _errormessgae(context),
                        );
                    }
                  }
                },
                    child: Text('Submit', style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xffe64241)),
                    padding: MaterialStateProperty.all(EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                            side: BorderSide(color: Color(0xffe64241)),
                      )
                    )
                  ),
                )
                ),
              // Text(val),
              ],
            )

          ),
        ],
      ),
      ),
        )
    );
  }
}
Widget _errormessgae(BuildContext context)
{
  return AlertDialog(
    backgroundColor: Color(0xffffe6e6),
    title: Text('Enter correct Consignment No.', style: TextStyle(color: Colors.red, fontSize: 17),),
    actions: <Widget>[
      new TextButton(onPressed: () {
        Navigator.of(context).pop();
      }, child: Text('Close'))
    ],
  );
}

Widget _buildPopupDialog(BuildContext context, List output){
  var size = MediaQuery.of(context).size;
  var length = size.width;
  return new AlertDialog(
    backgroundColor: Color(0xffffe6e6),
    titlePadding: EdgeInsets.only(left: length/7, top: 20),
    title: Text('Consignment details', style: TextStyle(color: Colors.red),),
    content: SingleChildScrollView(
    child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Consignment No:',style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black),),
          Text(output[0][0].toString(),style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black,)),
          /* RichText(
                text: TextSpan(
                    text: 'To Stn', style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black
                ),
                    children: <TextSpan>[
                      TextSpan(
                          text: output[0][2].toString(),style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black,)
                      )
                    ]
                ),
              ),*/
      ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Date:',style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black),),
              Text(output[0][4].toString(),style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black,))
              /* RichText(
                text: TextSpan(
                    text: 'To Stn', style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black
                ),
                    children: <TextSpan>[
                      TextSpan(
                          text: output[0][2].toString(),style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black,)
                      )
                    ]
                ),
              ),*/
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Package:',style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black),),
              Text(output[0][5].toString(),style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black,))
              /* RichText(
                text: TextSpan(
                    text: 'To Stn', style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black
                ),
                    children: <TextSpan>[
                      TextSpan(
                          text: output[0][2].toString(),style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black,)
                      )
                    ]
                ),
              ),*/
            ]),

        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            Text('From Stn:',style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black),),
           Text(output[0][1].toString(),style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black,))
              /* RichText(
                text: TextSpan(
                    text: 'To Stn', style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black
                ),
                    children: <TextSpan>[
                      TextSpan(
                          text: output[0][2].toString(),style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black,)
                      )
                    ]
                ),
              ),*/
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('To Stn:',style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black),),
            Text(output[0][2].toString(),style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black,))
             /* RichText(
                text: TextSpan(
                    text: 'To Stn', style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black
                ),
                    children: <TextSpan>[
                      TextSpan(
                          text: output[0][2].toString(),style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black,)
                      )
                    ]
                ),
              ),*/
            ]),


        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
             Text('Goods:',style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black),),
             Text(output[0][6].toString(),style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black,))
              /* RichText(
                text: TextSpan(
                    text: 'To Stn', style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black
                ),
                    children: <TextSpan>[
                      TextSpan(
                          text: output[0][2].toString(),style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black,)
                      )
                    ]
                ),
              ),*/
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            Text('Private Marka:',style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black),),
        Text(output[0][3].toString(),style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black,)),
              /* RichText(
                text: TextSpan(
                    text: 'To Stn', style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black
                ),
                    children: <TextSpan>[
                      TextSpan(
                          text: output[0][2].toString(),style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black,)
                      )
                    ]
                ),
              ),*/
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Consignee:  ',style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black),),

              Expanded(child: Text(output[0][7].toString(),style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black,), overflow: TextOverflow.fade,),)
              /* RichText(
                text: TextSpan(
                    text: 'To Stn', style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black
                ),
                    children: <TextSpan>[
                      TextSpan(
                          text: output[0][2].toString(),style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black,)
                      )
                    ]
                ),
              ),*/
            ]),
        Center(
          child:        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text('Current Status', style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.red,
          ),),
        ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 3),
          child: Text(output[0][8].toString(), style: TextStyle(fontSize: 17),),
        )
      ],
    ),
    ),
    actions: <Widget>[
      new TextButton(onPressed: () {
        Navigator.of(context).pop();
      }, child: Text('Close'))
    ],
  );
}