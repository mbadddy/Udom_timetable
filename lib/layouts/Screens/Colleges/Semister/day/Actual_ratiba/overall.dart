// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/Actual_ratiba/ratiba_card.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/Actual_ratiba/summary_card.dart';

class OverallAttendance extends StatefulWidget {
  String day;
  String semister;
  int year;
   OverallAttendance({
    Key? key,
    required this.day,
    required this.semister,
    required this.year,
  }) : super(key: key);
  @override
  _OverallAttendanceState createState() => _OverallAttendanceState();
}

class _OverallAttendanceState extends State<OverallAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        
        children: [
          Summary(title: widget.day, subtile: widget.semister, years: widget.year),
         Expanded(
          flex: 1,
          child:  Padding(padding: EdgeInsets.all(10),
          child: ListView(
            children: [
         OverallAttendanceCard(
          date: "15.12.2020",
          day: "sunday",
          firsthalf: true,
          secondhalf: false,
        ),
         OverallAttendanceCard(
          date: "15.12.2020",
          day: "sunday",
          firsthalf: true,
          secondhalf: false,
        ),
        OverallAttendanceCard(
          date: "15.12.2020",
          day: "sunday",
          firsthalf: true,
          secondhalf: false,
        ),
        OverallAttendanceCard(
          date: "15.12.2020",
          day: "sunday",
          firsthalf: true,
          secondhalf: false,
        ),
        OverallAttendanceCard(
          date: "15.12.2020",
          day: "sunday",
          firsthalf: true,
          secondhalf: false,
        ),
        OverallAttendanceCard(
          date: "15.12.2020",
          day: "sunday",
          firsthalf: true,
          secondhalf: false,
        ),
        OverallAttendanceCard(
          date: "15.12.2020",
          day: "sunday",
          firsthalf: true,
          secondhalf: false,
        ),
        OverallAttendanceCard(
          date: "15.12.2020",
          day: "sunday",
          firsthalf: true,
          secondhalf: false,
        ),
        OverallAttendanceCard(
          date: "15.12.2020",
          day: "sunday",
          firsthalf: true,
          secondhalf: false,
        ),
        OverallAttendanceCard(
          date: "15.12.2020",
          day: "sunday",
          firsthalf: true,
          secondhalf: false,
        ),
      ],),))

      ],)
    );
  }
}