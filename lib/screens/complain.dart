import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'menubar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrtc/screens/data.dart';
import 'package:mrtc/screens/modal.dart';
import 'package:mrtc/services.dart';
class complain extends StatefulWidget {
  @override
  _complainState createState() => _complainState();
}

class _complainState extends State<complain> {
  int count = 0;
  final _formkey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final firmcontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final complaintcontroller = TextEditingController();
  final consicontroller = TextEditingController();
  complaintdata modal = complaintdata();
  String value = "Select City";
  List<String> state = ['Select City'];
  bool isonline = true;

  void centres() async
  {
    isonline = await hasNetwork();
    var states = await getstates();
    var st;
    setState(() {
      st = states;
    });
    print("Here");
    print(st);
    List<int> statecodes = [];
    for (int i = 0; i < st.length; i++) {
      statecodes.add(st[i][0]);
    }
    //print(list);
    //print(state);
    for(int j = 0;j<statecodes.length;j++) {
      var centre = await getcentres(statecodes[j].toString());
      var cr;
      setState(() {
        cr = centre;
      });
      for (int i = 0; i < cr.length; i++) {
        state.add(cr[i][2].toString());
      }
    }
  }
  void initState(){
    centres();
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

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    },
    child:Scaffold(
        drawer: NavDrawer(route: '/complaint',),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Complaint"),
        ),
        body: SingleChildScrollView(
        child:Column(
          children: <Widget>[SingleChildScrollView(
            child:Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: height/50),
                    Text("Please fill the complete form", style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black)),),
                    Padding(padding: EdgeInsets.only(top: top, right: right, left: left, bottom: 15),
                      child: TextFormField(
                        controller: namecontroller,
                        minLines: 1,
                        decoration: InputDecoration(
                            hintText: "Enter you name",
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
                        value: value,
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
                            value = newValue!;
                          });
                          if (value != 'Select City') {
                            setState(() {
                              modal.city = value;
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
                        controller: firmcontroller,
                        minLines: 1,
                        decoration: InputDecoration(
                            hintText: "Enter your firm name",
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
                          modal.firm = value;
                        } ,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: top, right: right, left: left, bottom: 15),
                      child: TextFormField(
                        controller: phonecontroller,
                        minLines: 1,
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
                        controller: emailcontroller,
                        minLines: 1,
                        decoration: InputDecoration(
                            hintText: "Enter your email",
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
                          modal.email = value;
                        } ,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: top, right: right, left: left, bottom: 15),
                      child: TextFormField(
                        controller: consicontroller,
                        minLines: 1,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                            hintText: "Enter your Consignment No",
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
                          modal.consno = value;
                        } ,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: top, right: right, left: left, bottom: 15),
                      child: TextFormField(
                        controller: complaintcontroller,
                        minLines: 6,
                        maxLines: 8,
                        decoration: InputDecoration(
                          hintText: "Enter your complaint",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          suffixIcon: complaintcontroller.text.length>0? GestureDetector(
                            onTap: complaintcontroller.clear,
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
                          modal.complaint = value;
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
                if (_formkey.currentState!.validate()) {
                  _formkey.currentState?.save();
                  modal.date = DateTime.now();
                  savecomplain(modal);
                  FocusScope.of(context).unfocus();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _savemessage(context),
                  );
                  namecontroller.clear();
                  firmcontroller.clear();
                  complaintcontroller.clear();
                  phonecontroller.clear();
                  emailcontroller.clear();
                  consicontroller.clear();
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
                        borderRadius: BorderRadius.circular(12.0),
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
Widget _savemessage(BuildContext context)
{
  return AlertDialog(
    backgroundColor: Color(0xffffe6e6),
    title: Text('Sorry for the inconvenience.\n We will get back to you.', style: TextStyle(color: Colors.red, fontSize: 17),),
    actions: <Widget>[
      new TextButton(onPressed: () {
        Navigator.of(context).pop();
      }, child: Text('Close'))
    ],
  );
}