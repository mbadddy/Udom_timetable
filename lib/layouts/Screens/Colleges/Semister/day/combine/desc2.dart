// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';

class Description2 extends StatefulWidget {
 
  Description2({
    Key? key,
  }) : super(key: key);
  
  @override
  _Description2State createState() => _Description2State();
}

class _Description2State extends State<Description2>
    with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;
  Box<List<String>>? combinebox;
  @override
  void initState() {
   combinebox=Hive.box<List<String>>("combine");
    super.initState();

    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.2, 0.5, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.3, 0.5, curve: Curves.fastOutSlowIn)));
  }
 @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  
List<String>? collegess;
List<String>? yrs;
List<String>? sems;
List<String>? progs;
String? colleg;
String? yr;
String? semm;
String? progg;

  Widget build(BuildContext context) {
   collegess=combinebox!.get("colleges");
   progs=combinebox!.get("programmes");
   sems=combinebox!.get("semisters");
   yrs=combinebox!.get("years");
    if(collegess!=null)
    {
      for(var x=0;x<collegess!.length;x++){
          {
            setState(() {
         colleg=collegess![x];
         yr=yrs![x];
         semm=sems![x];
         progg=progs![x];
            });
        
          }
      }
    }

     Color appbar=appColr;
   final ThemeData mode = Theme.of(context);
   var whichMode=mode.brightness;
   if(whichMode==Brightness.dark){
    print("dark");
  setState(() {
          appbar=Colors.black12;
      });
}
    animationController.forward();
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animationController,
      builder: (context,child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 0, 10, 3),
          child: Container(
            alignment: Alignment(0, 0),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: appbar,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: height * 0.17,
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Transform(
                            transform: Matrix4.translationValues(
                                muchDelayedAnimation.value * width, 0, 0),
                            child: Center(
                              child: CircleAvatar(
                                radius: 28,
                                backgroundImage: AssetImage("assets/images/cive.jpg"),
                              ),
                            ),
                          ),
                          Transform(
                            transform: Matrix4.translationValues(
                                delayedAnimation.value * width, 0, 0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        color: Colors.orange[50],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "DETAILS FOR ALL COMBINE SESSIONS",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                  
                                      "Combined Table Is According To your Favourate",
                                      overflow: TextOverflow.ellipsis ,
                                      style: TextStyle(
                                        
                                        fontWeight: FontWeight.bold,
                                        fontSize:10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                          Text(
                                          "College: ${colleg}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "Programme: ${progg}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                        Padding(
                                    padding: const EdgeInsets.only(top: 8.0,left: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                          Text(
                                          "Year: ${yr}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Text(
                                          "Semister: ${semm}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
