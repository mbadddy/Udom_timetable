// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


import 'package:udom_timetable/layouts/Screens/Colleges/Semister/alltimetable.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/combine/create_combine.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/day.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';

class CombinedDays extends StatefulWidget {
  String semister;
  int year;
  String college;
  String programme;
  CombinedDays({
    Key? key,
    required this.semister,
    required this.year,
    required this.college,
    required this.programme,
  }) : super(key: key);
  @override
  _CombinedDaysState createState() => _CombinedDaysState();
}

class _CombinedDaysState extends State<CombinedDays> {
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
List<String> courses=["CP 316","CP 313","CP 318","CP 315"];
List<String> lectures=["Diwani","Siphaeli","Minja","Pascal"];

List<String> times=["08:00-10:00","07:00-09:30","10:00-12:00"];

void dialog(String day,String programe,String coll,String sem,String year){
  showDialog(context: context, builder: (context) {
    List<String> data;
    String course;
    String lect;
    String time;
    return  Dialog(
       elevation: 1,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(day),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Expanded(child: TextDropdownFormField(
                        options: courses,
                        decoration: InputDecoration(
                         
                        
                        border: OutlineInputBorder(),
                       suffixIcon: Icon(Icons.arrow_drop_down),
                       labelText: "Course"),
                        dropdownHeight: 220,
                        onChanged: (item) {
                          print(item);
                        },
                         ),),
                         SizedBox(width: 10),
                             Expanded(child: TextDropdownFormField(
                        options: times,
                        decoration: InputDecoration(
                        
                        border: OutlineInputBorder(),
                       suffixIcon: Icon(Icons.arrow_drop_down),
                       labelText: "Time"),
                        dropdownHeight: 220,
                        onChanged: (item) {
                          print(item);
                        },
                         ),),
                        
                              ],
                            ),
                             SizedBox(height: 20,),
                                       Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                      
                         SizedBox(width: 10),
                             Expanded(child: TextDropdownFormField(
                        options: lectures,
                        decoration: InputDecoration(
                        
                        border: OutlineInputBorder(),
                       suffixIcon: Icon(Icons.arrow_drop_down),
                       labelText: "Lecture"),
                        dropdownHeight: 220,
                         ),),
                        
                              ],
                            ),
                             SizedBox(height: 20),
                            ElevatedButton(onPressed:() { 
                              Navigator.pop(context);
                            },child: Text("Save"))
                          ],
                        ),
                      ),
                    );
  },);
  
}

  Box<String>? combinebox;
@override
  void initState() {
    combinebox=Hive.box<String>("combine");
    super.initState();
  }
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
                dialog("Monday", widget.programme, widget.college, widget.semister, widget.year.toString());
                
                 break;
                 case 1:
                  dialog("Tuesday", widget.programme, widget.college, widget.semister, widget.year.toString());
                 break;
                 case 2:
                  dialog("Wednesday", widget.programme, widget.college, widget.semister, widget.year.toString());
                 break;
                case 3:
                 dialog("Thursday", widget.programme, widget.college, widget.semister, widget.year.toString());
                 break;
                case 4:
                 dialog("Friday", widget.programme, widget.college, widget.semister, widget.year.toString());
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