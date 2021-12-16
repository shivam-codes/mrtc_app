import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tracking.dart';

class grid extends StatefulWidget {
  @override
  _gridState createState() => _gridState();
}

class _gridState extends State<grid> {
  Item item1 = new Item(
    title: "Service Location",
    img: "assets/image/service.png",
      page: "/service"
  );
  Item item2 = new Item(
      title: "Tracking",
      img: "assets/image/tracking.png",
      page: "/tracking",
  );
  Item item3 = new Item(
      title: "Claim",
      img: "assets/image/claim.png",
      page: "/claim"
  );
  Item item4 = new Item(
      title: "Complaint",
      img: "assets/image/complaint.png",
      page: "/complain"
  );
  Item item5 = new Item(
      title: "Feedback",
      img: "assets/image/feedback.png",
      page: "/feedback"
  );
  Item item6 = new Item(
      title: "Job Openings",
      img: "assets/image/vacancy.png",
    page: "/job"
  );
  @override
  Widget build(BuildContext context) {
    List<Item> mylist = [item1, item2, item3, item4, item5, item6];
    var size = MediaQuery.of(context).size;
    //print(size.height);
    //print(size.width);
    var color = 0xffe64241;
    return Container(
        child:GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 25, right: 25, top: size.height*.17,),
          crossAxisSpacing: size.width*0.085,
          mainAxisSpacing: size.height*0.05,
          children: mylist.map((data) {
            return InkWell(
                child: Container(
              decoration: BoxDecoration(
               color: Colors.white, borderRadius: BorderRadius.circular(10),
               boxShadow: [BoxShadow(
                 color: Color(color),
                 offset: const Offset(
                   3.0, 3.0,
                 ),
                 blurRadius: 5.0,
                 spreadRadius: 1.0,
               ),
                 BoxShadow(
                   color: Colors.white,
                   offset: const Offset(0.0, 0.0),
                   blurRadius: 0.0,
                   spreadRadius: 0.0,
                 ),]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top:10),
                    child:  Image(
                        image: AssetImage(data.img),
                      height: size.height*.08,
                    ),),


                    Padding(padding: EdgeInsets.only(top:size.height*.035),
                    child:   Text(data.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: size.width>330?15:14,
                              fontWeight: FontWeight.w600)), ),),
                  ],
                )
              ),
            onTap: () {
                  //print("tapped on");
                  Navigator.pushNamed(context, data.page);
            }
            ,);

          }).toList()
        ));
  }
}

class Item {
  String title;
  String img;
  String page;
  Item({this.title='', this.img='', this.page=''});
}
