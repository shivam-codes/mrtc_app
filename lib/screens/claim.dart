import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data.dart';
import 'package:mrtc/services.dart';
import 'modal.dart';

import 'menubar.dart';
class claim extends StatefulWidget {
  @override
  _claimState createState() => _claimState();
}

class _claimState extends State<claim> {
  final _formKey = GlobalKey<FormState>();
  final _cnmtcontroller = TextEditingController();
  final _cngecontroller = TextEditingController();
  final _namecontroller = TextEditingController();
  final _invoicecontroller = TextEditingController();
  final _claimcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final _invoicenocontroller = TextEditingController();
  final remarkcontroller = TextEditingController();
   String token_number = "1234567";
   claimdata modal = claimdata();
  var data;
  bool show_suffix = true;
  String errortext = "";
  bool _enabled = false;
  String val = "Select nature of claim";
  List<String> state = ['Select nature of claim'];
  List<String> states = ['Short', 'Damage', 'Lost/ND'];
  Map<String, int> st = {'Short':1, 'Damage':2, 'Lost/ND':3};
  bool isonline = true;
  void join (){
    state.addAll(states);
  }
  void check() async {
    isonline = await hasNetwork();
  }
  void initState() {
    join();
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var right = width/19;
    var left = width/19;
    var top = 6.0;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        setState(() {
          show_suffix = false;
        });
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          drawer: NavDrawer(route: '/claim',),
          appBar: AppBar(
            centerTitle: true,
            title: Text("Claim"),
          ),
          body: SingleChildScrollView(
              child:Column(
                  children: <Widget>[SingleChildScrollView(
                      child:Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: height/50),
                              //Text("Please fill the complete form", style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black)),),
                              Padding(padding: EdgeInsets.only(top: top, right: right, left: left, bottom: 15),
                                child: TextFormField(
                                  controller: _cnmtcontroller,
                                  minLines: 1,
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  decoration: InputDecoration(
                                      labelText: "Enter Consignment No.",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      ),
                                   suffix:(show_suffix || _cnmtcontroller.text.length==0)?Container(
                                     height:20,
                                       child:FittedBox(
                                         alignment: Alignment.center,
                                         fit: BoxFit.scaleDown,
                                         child:CircularProgressIndicator()),
                                  ):Padding(padding: EdgeInsets.zero,)),

                                  validator: (value)
                                  {
                                    if(value == null || value.length == 0)
                                    {
                                      return 'This field cannot be empty';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) async {
                                    if (value.length == 6 ||
                                        value.length == 7) {
                                      if (isonline == false) {
                                        final snackbar = SnackBar(
                                            content: Text('No Internet Connection. Try Again!'));
                                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                      }
                                      else
                                        {
                                      data = await verify(value.toString());
                                      var dat = data.body;
                                      data = jsonDecode(dat);
                                      print(data);
                                      if(data.length == 0)
                                        {
                                          setState(() {
                                            errortext = 'Invalid Consignment';
                                          });
                                        }
                                      else if (data[0][0] != '' && data[0][2] == '') {
                                        setState(() {
                                          _cngecontroller.text = data[0][1];
                                          _enabled = true;
                                          show_suffix = false;
                                          errortext = '';
                                        });
                                      }
                                      else if (data[0][2] != '') {
                                        setState(() {
                                          _cngecontroller.text = data[0][1];
                                          errortext =
                                          'Claim already registered';
                                        });
                                      }
                                    }}
                                    else
                                      {
                                        setState(() {
                                          _enabled= false;
                                          _cngecontroller.clear();
                                          show_suffix = true;
                                        });
                                      }
                                  },
                                  onSaved: (value) {
                                    modal.cnmt = value;
                                  } ,
                                ),
                              ),
                              SizedBox(
                                child: (errortext != '')?Padding(padding: EdgeInsets.only(bottom:5),
                                    child:Text(errortext, style: GoogleFonts.openSans(textStyle: TextStyle(
                                  fontSize: 17,color: Colors.red
                                )),)):Padding(padding: EdgeInsets.zero),
                              ),
                              Padding(padding: EdgeInsets.only(top: top, right: right, left: left, bottom: 15),
                                child: TextFormField(
                                  enabled: _enabled,
                                  controller: _cngecontroller,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                      labelText: "Consignee Name",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      )
                                  ),

                                  onSaved: (value) {
                                    modal.cnge = value;
                                  } ,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: top, right: right, left: left, bottom: 15),
                                child: TextFormField(
                                  enabled: _enabled,
                                  controller: _namecontroller,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                      labelText: "Enter your name",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      )
                                  ),

                                  onSaved: (value) {
                                    modal.name = value;
                                  } ,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: top, right: right, left: left, bottom: 15),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1.5)
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        filled: true,
                                        fillColor: Color(0xffffe6e6)
                                    ),
                                    dropdownColor: Color(0xffffe6e6),
                                    value: val,
                                    icon: const Icon(Icons.arrow_drop_down_outlined),
                                    iconSize: 24,
                                    elevation: 15,
                                    //isExpanded: true,
                                    //borderRadius: BorderRadius.circular(10),

                                    style: GoogleFonts.openSans(textStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        val = newValue!;
                                      });
                                      if (val != 'Select nature of claim') {
                                        setState(() {
                                          modal.type = st[val];
                                        });
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
                              Padding(padding: EdgeInsets.only(top: top, right: right, left: left, bottom: 15),
                                child: TextFormField(
                                  enabled: _enabled,
                                  controller: _invoicenocontroller,
                                  minLines: 1,
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                                  decoration: InputDecoration(
                                      labelText: "Enter Invoice number",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      )
                                  ),
                                  validator: (value)
                                  {
                                    if(value == null || value.length == 0)
                                    {
                                      return 'This field cannot be empty';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    modal.invoiceno = value;
                                  } ,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: top, right: right, left: left, bottom: 15),
                                child: TextFormField(
                                  enabled: _enabled,
                                  controller: _invoicecontroller,
                                  minLines: 1,
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                                  decoration: InputDecoration(
                                      labelText: "Enter Invoice value",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      )
                                  ),
                                  validator: (value)
                                  {
                                    if(value == null || value.length == 0)
                                    {
                                      return 'This field cannot be empty';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    modal.invoice = double.parse(value!);
                                  } ,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: top, right: right, left: left, bottom: 15),
                                child: TextFormField(
                                  enabled: _enabled,
                                  controller: _claimcontroller,
                                  minLines: 1,
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
                                  decoration: InputDecoration(
                                      labelText: "Enter claim amount",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      )
                                  ),
                                  validator: (value)
                                  {
                                    if(value == null || value.length == 0)
                                    {
                                      return 'This field cannot be empty';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    modal.claimamnt = double.parse(value!);
                                  } ,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: top, right: right, left: left, bottom: 15),
                                child: TextFormField(
                                  enabled: _enabled,
                                  controller: phonecontroller,
                                  minLines: 1,
                                  maxLength: 10,
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  decoration: InputDecoration(
                                      hintText: "Enter your phone no.",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      )
                                  ),
                                  validator: (value)
                                  {
                                    if(value == null || value.length == 0)
                                    {
                                      return 'This field cannot be empty';
                                    }
                                    else if(value.length < 10 || value.length > 10)
                                    {
                                      return 'Enter valid phone no';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    modal.phone = value;
                                  } ,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: top, right: right, left: left, bottom: 15),
                                child: TextFormField(
                                  enabled: _enabled,
                                  controller: remarkcontroller,
                                  minLines: 4,
                                  maxLines: 8,
                                  decoration: InputDecoration(
                                    hintText: "Enter your comments",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    suffixIcon: remarkcontroller.text.length>0? GestureDetector(
                                      onTap: remarkcontroller.clear,
                                      child: Icon(Icons.clear_rounded),
                                    ):null,
                                  ),
                                  validator: (value)
                                  {
                                    if(value == null || value.length == 0)
                                    {
                                      return 'This field cannot be empty';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    modal.remark = value;
                                  } ,
                                ),
                              ),
                            ],
                          )
                      )
                  ),
                    ElevatedButton(onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (isonline == false) {
                        setState(() {
                          FocusScope.of(context).unfocus();
                        });
                        final snackbar = SnackBar(
                            content: Text('No Internet Connection. Try Again!'));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                      else {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          saveclaim(modal);
                          var output = await gettoken(modal.cnmt!);
                          output = output.body;
                          output = jsonDecode(output);
                          //output = jsonDecode(output);
                          FocusScope.of(context).unfocus();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _savemessage(context, output[0][0]),
                          );
                          _cnmtcontroller.clear();
                          _cngecontroller.clear();
                          _namecontroller.clear();
                          _invoicecontroller.clear();
                          _invoicenocontroller.clear();
                          remarkcontroller.clear();
                          phonecontroller.clear();
                          _claimcontroller.clear();

                          //Navigator.pop(context);
                        }
                      }

                    },
                      child: Text('Submit', style: TextStyle(color: Colors.white,
                        fontSize: 17,),),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xffe64241)),
                          padding: MaterialStateProperty.all(EdgeInsets.only(top:10,bottom: 10,left:width*0.3,right:width*0.3)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Color(0xffe64241)),
                              )
                          )
                      ),
                    )
                  ]
              )
          )
      )
    );
  }
}
Widget _savemessage(BuildContext context, String token)
{
  return AlertDialog(
    backgroundColor: Color(0xffffe6e6),
    title: Text('Sorry for the inconvenience.\n We will get back to you.', style: TextStyle(color: Colors.red, fontSize: 17),),
    content: Text('Your token no. is ${token}', style: TextStyle(color: Colors.red, fontSize: 17)),
    actions: <Widget>[
      new TextButton(onPressed: () {
        Navigator.of(context).pop();
      }, child: Text('Close'))
    ],
  );
}

