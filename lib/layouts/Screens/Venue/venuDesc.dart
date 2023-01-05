// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';

class VDescription extends StatefulWidget {
  String college;
  String total;
  VDescription({
    Key? key,
    required this.college,
    required this.total,
  }) : super(key: key);
  
  @override
  _VDescriptionState createState() => _VDescriptionState();
}

class _VDescriptionState extends State<VDescription>
    with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  @override
  void initState() {

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
  String description='';
  @override
  Widget build(BuildContext context) {
    setState(() {
        if(widget.college=="CIVE"){
             description="College Of Informatics And Virtual Education";
             }
    });
 
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
                child:  Column(
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
                                        "COLLEGE VENUES",
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
                                  
                                      "${description}",
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
                                          "College: ${widget.college}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "Total: ${widget.total}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                   
                                  ),
                                SizedBox(height: 10,),
                                const Text("In Order to obtain correctly all Free Venues,",style: TextStyle(fontSize: 10,color: Colors.white),),
                                const Text("Make Sure you Synchronize All of the College Data",style: TextStyle(fontSize: 10,color:Colors.white),)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),)
                
           
              ),
            ),
          
        );
      },
    );
  }
}
