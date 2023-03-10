// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';

class OverallTimetableCard extends StatefulWidget {
  final String? venue;
  final String? time;
  final String? instructor;
  final String? course;
  final String? category;
  const OverallTimetableCard(
    Key? key,
    this.venue,
    this.time,
    this.instructor,
    this.course,
    this.category,
  ) : super(key: key);

  @override
  _OverallTimetableCardState createState() => _OverallTimetableCardState();
}

class _OverallTimetableCardState extends State<OverallTimetableCard>
    with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    // splitTime(widget.time);
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
  //   void splitTime(String? period){
  //       var array=period!.split("-");
  //       DateTime dt1=DateTime.parse(array[1]);
  //        DateTime dt2=DateTime.parse(array[2]);
  //        Duration dur=dt1.difference(dt2);
  //        print("Duration is ${dur}");
  // }
 
  @override
  Widget build(BuildContext context) {
    print("instructor ${widget.instructor!.length}...................................");

if(widget.category!=null){
  print("category is ${widget.category}............................");
}


    var arr=widget.time!.split("-");
    var noww=DateTime.now();
    var splitted_now=noww.toString().split(" ");
    var splitted_now2=noww.toString().split(" ");
    var dttt1;
     var dttt2;
     var dttttt1;
     var dttttt2;
     var category;
     int lectures=0;
     int tutorials=0;
     int labs=0;
    setState(() {
      print(arr);
      arr[1]="${arr[1]}:00";
      arr[0]="${arr[0].replaceAll(' ', '')}:00";
       splitted_now2[1]=arr[1];
       dttt1=splitted_now2;
         splitted_now[1]=arr[0];
         dttt2=splitted_now;
        dttttt1=dttt1[0]+""+dttt1[1];
         dttttt2=dttt2[0]+" "+dttt2[1];
         print("new date1 ${dttttt1}");
         print("new date2 ${dttttt2}");
    });
   
   
      DateTime dt1=DateTime.parse(dttttt1);
      DateTime dt2=DateTime.parse(dttttt2);
      Duration durr=dt1.difference(dt2);
     
       setState(() {
          
             if(durr.inMinutes<120){
            category="Tutorial";
            tutorials++;
                }
                else if(widget.venue!.toLowerCase().contains("lab")){
                category="Labaratory"; 
                 labs++;
                }
                else{
              category="Lecture"; 
              lectures++;
                }
        });
    
     print("Duration ${durr.inMinutes}");
    
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
       Color appbar=appColr;
   Color indicator=Colors.white70;
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
                     
                    ],
                  ),
                   SizedBox(
                        width: 10,
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
                      SizedBox(
                        width: 130,
                        child: Text(
                        "${widget.instructor}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                         
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ), ),
                     
                    ],
                  ),
          
                         Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${category}",
                        style: TextStyle(
                        
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                         SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 80,
                        child:Text(
                        "${widget.venue}",
                        style: TextStyle(
                           overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),),
                          
                    ],
                  ),
               
                      //  IconButton(
                      //   alignment: Alignment.centerRight,
                      //   color: appColr,
                      //   iconSize: 18,
                      //   onPressed: () {
                        
                      //    print("favourate");
                      //  }, icon: Icon(Icons.star_border))
                  

                
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
