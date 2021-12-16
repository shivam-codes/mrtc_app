import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrtc/screens/data.dart';
import 'menubar.dart';
import 'modal.dart';
import 'package:mrtc/services.dart';
class feedback extends StatefulWidget {
  @override
  _feedbackState createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
  final _formKey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final firmcontroller = TextEditingController();
  final feedbackcontroller = TextEditingController();
  Modelfeed modal = Modelfeed();
  bool isonline = true;
  void check() async {
    isonline = await hasNetwork();
  }
  void initState() {
    check();
    super.initState();
}
  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    firmcontroller.dispose();
    feedbackcontroller.dispose();
  }
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var right = width/15;
    var left = width/15;
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
          new TextEditingController().clear();
        },
        child:Scaffold(
        drawer: NavDrawer(route: '/feedback',),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Feedback"),
        ),
        body: SingleChildScrollView(
    child:Form(
         key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: height/40),
              Text("Enter your feedback", style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black)),),
              Padding(padding: EdgeInsets.only(top: 10, right: right, left: left, bottom: 15),
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
              Padding(padding: EdgeInsets.only(top: 10, right: right, left: left, bottom: 15),
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
              Padding(padding: EdgeInsets.only(top: 6, right: right, left: left, bottom: 15),
                child: TextFormField(
                  controller: feedbackcontroller,
                minLines: 8,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: "Enter your feedback",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  suffixIcon: feedbackcontroller.text.length>0? GestureDetector(
                  onTap: feedbackcontroller.clear,
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
                    modal.feedback = value;
                  } ,
                ),
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
                    modal.date = DateTime.now();
                    savefeedback(modal);
                    FocusScope.of(context).unfocus();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _savemessage(context),
                    );
                    namecontroller.clear();
                    firmcontroller.clear();
                    feedbackcontroller.clear();
                    //Navigator.pop(context);
                  }
                }
              },
                  child: Text('Submit', style: TextStyle(color: Colors.white,
                    fontSize: 16.5,),),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xffe64241)),
                    padding: MaterialStateProperty.all(EdgeInsets.only(top:10, bottom: 10, left:width*0.2, right:width*0.2)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: Color(0xffe64241)),
                        )
                    )
                ),
              )
            ],
          )
        )
        ))
    );
  }
}
Widget _savemessage(BuildContext context)
{
  return AlertDialog(
    backgroundColor: Color(0xffffe6e6),
    title: Text('Thank you for your feedback', style: TextStyle(color: Colors.red, fontSize: 17),),
    actions: <Widget>[
      new TextButton(onPressed: () {
        Navigator.of(context).pop();
      }, child: Text('Close'))
    ],
  );
}