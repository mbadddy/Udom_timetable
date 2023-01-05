// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:udom_timetable/layouts/Screens/Colleges/Semister/alltimetable.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/day.dart';

class OverallAttendance extends StatefulWidget {
  String semister;
  int year;
  String college;
  String programme;
  OverallAttendance({
    Key? key,
    required this.semister,
    required this.year,
    required this.college,
    required this.programme,
  }) : super(key: key);
  @override
  _OverallAttendanceState createState() => _OverallAttendanceState();
}

class _OverallAttendanceState extends State<OverallAttendance> {
  final List<Widget> days=[ 
        OverallAttendanceCard(
         
          day: "Monday",
          
        ),
        OverallAttendanceCard(
         
          day: "Tuesday",
        
        ),
        OverallAttendanceCard(
         
          day: "Wednesday",
        
        ),
        OverallAttendanceCard(
         
          day: "Thursday",
         
        ),
       OverallAttendanceCard(
         
          day: "Friday",
         
        ),
  ];
  @override
  Widget build(BuildContext context) {
    print("tile "+widget.college+widget.programme);
    return Scaffold(
      body: 
      Padding(
      padding: EdgeInsets.only(bottom: 60),
        
        child:  ListView.separated(
          itemBuilder: (context, index) {
            Widget myday=days[index];
            return ListTile(
             title: myday,
             onTap: () {
              switch(index){
                 case 0:
                 Navigator.push(context, MaterialPageRoute(builder: (context) => 
                 Day(title: 'Monday', semister: widget.semister, year: widget.year,
                  college: widget.college, programme: widget.programme,),));
                 break;
                 case 1:
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                   Day(title: 'Tuesday',semister: widget.semister, year: widget.year, 
                   college: widget.college, programme: widget.programme,),));
                 break;
                 case 2:
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                   Day(title: 'Wednesday',semister: widget.semister, year: widget.year,
                    college: widget.college, programme: widget.programme,),));
                 break;
                case 3:
                 Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  Day(title: 'Thursday',semister: widget.semister, year: widget.year, 
                  college: widget.college, programme: widget.programme,),));
                 break;
                case 4:
                 Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  Day(title: 'Friday',semister: widget.semister, year: widget.year, 
                  college: widget.college, programme: widget.programme,),));
                 break;
                 default:
                 print("sunday");
              }
           
             },
            );
          }, 
          separatorBuilder: (context, index) => Divider(), 
          itemCount: days.length)
      )
     
    );
  }
}