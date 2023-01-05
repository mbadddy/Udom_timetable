// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';

class SessionCard extends StatefulWidget {
  final String? time;
  final String? course;
  final String? lecture;
  final String? prog;
  final String? sem;
  final String? yerrr;
  final String? category;
  const SessionCard(
    Key? key,
    this.time,
    this.course,
    this.lecture,
    this.prog,
    this.sem,
    this.yerrr,
    this.category,
  ) : super(key: key);

  @override
  _SessionCardState createState() => _SessionCardState();
}

class _SessionCardState extends State<SessionCard>
    with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation;
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
        curve: Interval(0.2, 0.6, curve: Curves.fastOutSlowIn)));
  }
  @override
  void dispose() {
  
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    combinebox=Hive.box<List<String>>("combine");
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
       Color appbar=appColr;
   Color indicator=Color.fromARGB(103, 233, 224, 224);
   Color unselected=Colors.black26;
   final ThemeData mode = Theme.of(context);
   var whichMode=mode.brightness;
   if(whichMode==Brightness.dark){
  setState(() {
          appbar=Colors.black12;
          indicator=Colors.black12;
          unselected=Colors.white38;
      });
}
    return AnimatedBuilder(
      animation: animationController,
      builder: (context,child) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Transform(
            transform:
                Matrix4.translationValues(delayedAnimation.value * width, 0, 0),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 13,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: indicator,
                boxShadow: [
                  BoxShadow(
                    color: indicator,
                    offset: Offset(0, 3),
                    //blurRadius: 3,
                    //spreadRadius: 1,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${widget.time}",
                        style: TextStyle(
                          
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                     Text(
                        "${widget.prog}",
                        style: TextStyle(
                          
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.course}",
                        style: TextStyle(
                         
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${widget.category}",
                        style: TextStyle(
                         
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 135,
                      child: Text(
                        "${widget.lecture}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                         
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),),
                      SizedBox(height: 10,),
                      Text("year ${widget.yerrr}",
                      style: TextStyle(
                         
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),)
                    
                    ],
                  ),
],
              ),
            ),
          ),
        );
      },
    );
  }
}
