import 'package:flutter/material.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';

class OverallAttendanceCard extends StatefulWidget {
  final String? date;
  final String? day;
  final bool? firsthalf;
  final bool? secondhalf;

  const OverallAttendanceCard(
      {Key? key, this.date, this.day, this.firsthalf, this.secondhalf})
      : super(key: key);

  @override
  _OverallAttendanceCardState createState() => _OverallAttendanceCardState();
}

class _OverallAttendanceCardState extends State<OverallAttendanceCard>
    with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
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
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
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
                        "08:00-10:00",
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
                        "CP 316",
                        style: TextStyle(
                         
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Ally Nyamawe",
                        style: TextStyle(
                         
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
          
                         Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lecture",
                        style: TextStyle(
                        
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                         SizedBox(
                        height: 10,
                      ),
                           Text(
                        "LRB 106",
                        style: TextStyle(
                         
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
               
                       IconButton(
                        alignment: Alignment.centerRight,
                        color: appColr,
                        iconSize: 18,
                        onPressed: () {
                        
                         print("favourate");
                       }, icon: Icon(Icons.star_border))
                  

                
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
