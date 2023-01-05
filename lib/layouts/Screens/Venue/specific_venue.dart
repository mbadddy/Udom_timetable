// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/Screens/Venue/session_card.dart';
import 'package:udom_timetable/layouts/Screens/Venue/specific_v_desc.dart';

class SpecificVenue extends StatefulWidget {
  String venue;
  String college;
  SpecificVenue({
    Key? key,
    required this.venue,
    required this.college,
  }) : super(key: key);

  @override
  State<SpecificVenue> createState() => _SpecificVenueState();
}
  
class _SpecificVenueState extends State<SpecificVenue> {
  String selectedValue = "Monday";
    SharedPreferences? sharedPreferences;
    Box<List<String>>? all_timetable;

  List<String>? venyuuuuuus;
  List<String>? collgs;
   List<String>? proggggs;
   List<String>? yerrrs;
  List<String>? semmms;
   List<String>? lectureees;
   List<String>? tymesss;
   List<String>? dayyys;
   List<String>? categoryyyys;
   List<String>? coursesss;
   //tempo
   List<String> cozes=[];
   List<String> categs=[];
   List<String> tymes=[];
   List<String> progs=[];
   List<String> yrs=[];
   List<String> sems=[];
   List<String> instructs=[];
   bool initializer=false;
   clearData(){
             
               if(progs.isNotEmpty){
                print("clearing............");
                progs.clear();
               cozes.clear();
               yrs.clear();
               categs.clear();
               tymes.clear();
               sems.clear();
               instructs.clear();
               }
               else{
            print("empty............");
               }
            
             
   }
   addData(){
    print("adding............");
   if(venyuuuuuus!=null){
    setState(() {
      initializer=true;
      for(var v=0;v<venyuuuuuus!.length;v++){
         if(dayyys![v]==selectedValue && venyuuuuuus![v]==widget.venue){
          
           
           progs.add(proggggs![v]);
           cozes.add(coursesss![v]);
           yrs.add(yerrrs![v]);
           categs.add(categoryyyys![v]);
           tymes.add(tymesss![v]);
           sems.add(semmms![v]);
           instructs.add(lectureees![v]);
       
         
        
         }

      }
    });
  }
   }
   @override
  void initState() {
     all_timetable=Hive.box<List<String>>("timetable");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

        Color appbar=appColr;
  
 final ThemeData mode = Theme.of(context);
var whichMode=mode.brightness;
if(whichMode==Brightness.dark){
  setState(() {
          appbar=Colors.black12;
      });
}
//operations
     venyuuuuuus=all_timetable!.get("venues");
     collgs=all_timetable!.get("colleges");
     proggggs=all_timetable!.get("programmes");
     yerrrs=all_timetable!.get("years");
     semmms=all_timetable!.get("semisters");
     lectureees=all_timetable!.get("lectures");
     tymesss=all_timetable!.get("times");
     dayyys=all_timetable!.get("days");
     categoryyyys=all_timetable!.get("categories");
     coursesss=all_timetable!.get("courses");

if(venyuuuuuus!=null && initializer==false){
    setState(() {
     
      for(var v=0;v<venyuuuuuus!.length;v++){
         if(dayyys![v]==selectedValue && venyuuuuuus![v]==widget.venue){
          
           
           progs.add(proggggs![v]);
           cozes.add(coursesss![v]);
           yrs.add(yerrrs![v]);
           categs.add(categoryyyys![v]);
           tymes.add(tymesss![v]);
           sems.add(semmms![v]);
           instructs.add(lectureees![v]);
       
         
        
         }

      }
    });
  }

    return Scaffold(
      appBar: AppBar(
         leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: () {
          Navigator.of(context).pop();
        },),
      title:new Text("${widget.venue}"),
        centerTitle: true,
        backgroundColor: appbar,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: [
          Padding(padding: EdgeInsets.only(right: 5,left: 5),
          child: SpecificVDescription(college: widget.college, sessions: cozes.length.toString(),),),

   Padding(padding: EdgeInsets.only(top: 5),
   child:           Container(
                    height: 40,
                    width: 200,
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                    ),
                    child:DropdownButtonHideUnderline(child:            DropdownButton<String>(
                      value: selectedValue,
                      borderRadius: BorderRadius.circular(30.0),
                      elevation: 20,
                      isExpanded: true,
         
               items: <String>['Monday', 'Tuesday', 'Wednesday', 'Thursday','Friday'].map((String value) {
               return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
                   );
              }).toList(),
             onChanged:(value) {
              setState(() {
                selectedValue=value!;
                clearData();
                addData();
              });
               print("${value}.....");
             },
),),
                    
           
),),

Expanded(
          flex: 1,
          child:  Padding(padding: EdgeInsets.all(10),
          child:  cozes.isEmpty?
          Center(child:Text("No Sessions Available")):
          ListView.builder(
            itemCount: cozes.length,
            itemBuilder: (context, index) {
              return SessionCard(null, tymes[index], cozes[index], instructs[index], 
              progs[index], sems[index], yrs[index], categs[index]);
             
          },)
      )
      ),     
        ],
      ),
    );
  }
}