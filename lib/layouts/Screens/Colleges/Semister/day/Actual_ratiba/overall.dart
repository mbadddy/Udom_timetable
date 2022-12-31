// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/Actual_ratiba/ratiba_card.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/Actual_ratiba/summary_card.dart';
import 'package:udom_timetable/services/Modal/timetable.dart';
import 'package:udom_timetable/services/timetable_Service.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import '../../../../../../main.dart';

class OverallAttendance extends StatefulWidget {
  String day;
  String semister;
  int year;
  String programme;
  String college;
  OverallAttendance({
    Key? key,
    required this.day,
    required this.semister,
    required this.year,
    required this.programme,
    required this.college,
  }) : super(key: key);
  @override
  _OverallAttendanceState createState() => _OverallAttendanceState();
}

class _OverallAttendanceState extends State<OverallAttendance> {
  Box<List<String>>? all_timetable;
  TimetableService service=TimetableService();
    late Future<Timetable> timetable;
    Future<int>? status;
    @override
  void initState() {
    all_timetable=Hive.box<List<String>>("timetable");
    getDaysData();
    // all_timetable!.deleteAll(all_timetable!.keys);
    filterFuction();
   timetable=service.fetchTimetable();
    super.initState();
  }
   int? dy;
    int? prog;
    void filterFuction(){
      setState(() {
            if(widget.day=="Monday"){
             dy=1;
              }
            if(widget.day=="Tuesday"){
             dy=2;
              }
            if(widget.day=="Wednesday"){
             dy=3;
              }
            if(widget.day=="Thursday"){
             dy=4;
              }
            if(widget.day=="Friday"){
             dy=5;
              }
      });
       if(widget.college=="CIVE")
    {
      setState(() {
         
         if(widget.year==1 && widget.semister=="ONE"){
           if(widget.programme=="BCs-CS"){
              prog=1;
           }
          if(widget.programme=="BCs-SE"){
              prog=4;
            }
          if(widget.programme=="BCs-TE"){
              prog=8;
           }
          if(widget.programme=="BCs-CNISE"){
              prog=12;
            }
          if(widget.programme=="BCs-HIS"){
              prog=16;
           }
          if(widget.programme=="BCs-BIS"){
              prog=19;
            }
           if(widget.programme=="BCs-CE"){
              prog=22;
            }
          if(widget.programme=="BCs-MTA"){
              prog=26;
           }
          if(widget.programme=="BCs-IS"){
              prog=29;
            }
         
           }
        if(widget.year==2 && widget.semister=="ONE"){
              if(widget.programme=="BCs-CS"){
              prog=2;
           }
               if(widget.programme=="BCs-SE"){
              prog=5;
           }
           if(widget.programme=="BCs-TE"){
              prog=9;
           }
          if(widget.programme=="BCs-CNISE"){
              prog=13;
            }
          if(widget.programme=="BCs-HIS"){
              prog=17;
           }
          if(widget.programme=="BCs-BIS"){
              prog=20;
            }
           if(widget.programme=="BCs-CE"){
              prog=23;
            }
          if(widget.programme=="BCs-MTA"){
              prog=27;
           }
          if(widget.programme=="BCs-IS"){
              prog=30;
            }
      }
        if(widget.year==3 && widget.semister=="ONE"){
            if(widget.programme=="BCs-CS"){
              prog=3;
           }
               if(widget.programme=="BCs-SE"){
              prog=6;
           }
          if(widget.programme=="BCs-TE"){
              prog=10;
           }
          if(widget.programme=="BCs-CNISE"){
              prog=14;
            }
          if(widget.programme=="BCs-HIS"){
              prog=18;
           }
          if(widget.programme=="BCs-BIS"){
              prog=21;
            }
           if(widget.programme=="BCs-CE"){
              prog=24;
            }
          if(widget.programme=="BCs-MTA"){
              prog=28;
           }
          if(widget.programme=="BCs-IS"){
              prog=31;
            }
      }
         if(widget.year==4 && widget.semister=="ONE"){
               if(widget.programme=="BCs-SE"){
                 prog=7;
                }
            if(widget.programme=="BCs-TE"){
              prog=11;
           }
          if(widget.programme=="BCs-CNISE"){
              prog=15;
            }
       
           if(widget.programme=="BCs-CE"){
              prog=25;
            }
      }
        
      
      });
 
    }
    }
    int sessions=0;
    int lectures=0;
    int labbs=0;
    int tutoriallls=0;



bool checker=false;
 void putData(String day,String sem,String coll,String programe,String course,
 String venue,String lecture,String category,String time,String year)async{

  List<String> programmes=[];
    List<String> years=[];
    List<String> semisters=[];
    List<String> days=[];
    List<String> cozesss=[];
    List<String> venues=[];
    List<String> instructorss=[];
    List<String> times=[];
    List<String> categoryys=[];
    List<String> colleges=[];
 
            if(all_timetable!.get("courses")!=null){
              print("courses ${all_timetable!.get("courses")}");
              print("times ${all_timetable!.get("times")}");
              print("programmes ${all_timetable!.get("programmes")}");
                  for(var x=0;x<all_timetable!.get("categories")!.length;x++){
                    if(all_timetable!.get("courses")![x]==course && all_timetable!.get("lectures")![x]==lecture
                    && all_timetable!.get("venues")![x]==venue && all_timetable!.get("categories")![x]==category &&
                    all_timetable!.get("times")![x]==time && all_timetable!.get("semisters")![x]==sem && 
                    all_timetable!.get("programmes")![x]==programe && all_timetable!.get("days")![x]==day
                    && all_timetable!.get("colleges")![x]==coll &&  all_timetable!.get("years")![x]==year
                   ){
                   setState(() {
                     checker=true;
                   });

                   }}}
                   if(checker==true){
                  print("skipped..................................");
                   }
                   else{
 if(all_timetable!.get('days')==null){
                                    days.add(day);
                                   all_timetable!.put("days", days);
                                }
                                else{
          
                                   List<String>? dayss=all_timetable!.get('days');
                                      days.add(day);
                                    for(var d=0;d<dayss!.length;d++)
                                     {
                                    print(dayss[d].toString()+" added");
                                        days.add(dayss[d].toString());
                                       }
                                      all_timetable!.put("days", days);
                                     }
                                      
                               if(all_timetable!.get('semisters')==null){
                                   semisters.add(sem);
                                   all_timetable!.put("semisters", semisters);
                                }
                                else{
          
                                   List<String>? semistes=all_timetable!.get('semisters');
                                      semisters.add(sem);
                                    for(var d=0;d<semistes!.length;d++)
                                     {
                                       print(semistes[d].toString()+" added");
                                        semisters.add(semistes[d].toString());
                                       }
                                      all_timetable!.put("semisters", semisters);
                                     }

  // data=[,,,,,course.value!,time.value!,lecture.value!];

                                 if(all_timetable!.get('colleges')==null){
                                   colleges.add(coll);
                                   all_timetable!.put("colleges", colleges);
                                 }
                                else{
          
                                   List<String>? coleges=all_timetable!.get('colleges');
                                      colleges.add(coll);
                                    for(var d=0;d<coleges!.length;d++)
                                     {
                                       print(coleges[d].toString()+" added");
                                        colleges.add(coleges[d].toString());
                                       }
                                      all_timetable!.put("colleges", colleges);
                                     }
                                     
                                 if(all_timetable!.get('programmes')==null){
                                   programmes.add(programe);
                                   all_timetable!.put("programmes", programmes);
                                 }
                                else{
          
                                   List<String>? programes=all_timetable!.get('programmes');
                                      programmes.add(programe);
                                    for(var d=0;d<programes!.length;d++)
                                     {
                                       print(programes[d].toString()+" added");
                                        programmes.add(programes[d].toString());
                                       }
                                      all_timetable!.put("programmes", programmes);
                                     }

                               if(all_timetable!.get('years')==null){
                                   years.add(year);
                                   all_timetable!.put("years", years);
                                 }
                                else{
          
                                   List<String>? yrs=all_timetable!.get('years');
                                      years.add(year);
                                    for(var d=0;d<yrs!.length;d++)
                                     {
                                       print(yrs[d].toString()+" added");
                                        years.add(yrs[d].toString());
                                       }
                                      all_timetable!.put("years", years);
                                     }

                               if(all_timetable!.get('courses')==null){
                                   cozesss.add(course);
                                   all_timetable!.put("courses", cozesss);
                                 }
                                else{
          
                                   List<String>? crses=all_timetable!.get('courses');
                                      cozesss.add(course);
                                    for(var d=0;d<crses!.length;d++)
                                     {
                                       print(crses[d].toString()+" added");
                                        cozesss.add(crses[d].toString());
                                       }
                                      all_timetable!.put("courses", cozesss);
                                     }
                                  
                             if(all_timetable!.get('lectures')==null){
                                   instructorss.add(lecture);
                                   all_timetable!.put("lectures", instructorss);
                                 }
                                else{
          
                                   List<String>? lect=all_timetable!.get('lectures');
                                      instructorss.add(lecture);
                                    for(var d=0;d<lect!.length;d++)
                                     {
                                        print(lect[d].toString()+" added");
                                        instructorss.add(lect[d].toString());
                                       }
                                      all_timetable!.put("lectures", instructorss);
                                     }

                              if(all_timetable!.get('times')==null){
                                   times.add(time);
                                   all_timetable!.put("times", times);
                                 }
                                else{
          
                                   List<String>? timess=all_timetable!.get('times');
                                      times.add(time);
                                    for(var d=0;d<timess!.length;d++)
                                     {
                                       print(timess[d].toString()+" added");
                                        times.add(timess[d].toString());
                                       }
                                      all_timetable!.put("times", times);
                                     }
                               
                                     
                                if(all_timetable!.get('venues')==null){
                                   venues.add(venue);
                                   all_timetable!.put("venues", venues);
                                 }
                                else{
          
                                   List<String>? venuees=all_timetable!.get('venues');
                                      venues.add(venue);
                                    for(var d=0;d<venuees!.length;d++)
                                     {
                                       print(venuees[d].toString()+" added");
                                        venues.add(venuees[d].toString());
                                       }
                                      all_timetable!.put("venues", venues);
                                     }

                               if(all_timetable!.get('categories')==null){
                                   categoryys.add(category);
                                   all_timetable!.put("categories", categoryys);
                                 }
                                else{
          
                                   List<String>? categories=all_timetable!.get('categories');
                                      categoryys.add(category);
                                    for(var d=0;d<categories!.length;d++)
                                     {
                                       print(categories[d].toString()+" added");
                                        categoryys.add(categories[d].toString());
                                       }
                                      all_timetable!.put("categories", categoryys);
                                     }

                   }
 
 }
List<String>? d_progs;
List<String>? d_colls;
List<String>? d_yrs;
List<String>? d_sems;
List<String>? d_days;
Future<void> getDaysData()async{
SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
setState(() {
      d_colls=sharedPreferences.getStringList("colleges"); 
          d_progs=sharedPreferences.getStringList("programes");
           d_yrs=sharedPreferences.getStringList("years");
            d_sems=sharedPreferences.getStringList("semisters");
             d_days=sharedPreferences.getStringList("days");
});
}
  bool isOnline=false;
  @override
  Widget build(BuildContext context) {
       AndroidAlarmManager.periodic(const Duration(seconds: 60),2,callBackDyDispacher,params: {
    "d_programes":d_progs,
    "d_colleges":d_colls,
    "d_years":d_yrs,
    "d_semister":d_sems,
    "d_day":d_days,

    "dt_venues":all_timetable!.get("venues"),
    "dt_days":all_timetable!.get("days"),
    "dt_instruct":all_timetable!.get("lectures"),
    "dt_tyme":all_timetable!.get("times"),
    "dt_cozes":all_timetable!.get("courses"),
    "dt_catgry":all_timetable!.get("categories"),
    "dt_progs":all_timetable!.get("programmes"),
    "dt_yr":all_timetable!.get("years"),
    "dt_sem":all_timetable!.get("semisters")

   },rescheduleOnReboot: true,wakeup: true,exact: true);


   return Scaffold(
      body: Column(
        
        children: [
          Summary(title: widget.day, subtile: widget.semister, years: widget.year, 
          sessions: sessions, labs: labbs, tutoris: tutoriallls, lectues: lectures,),
         Expanded(
          flex: 1,
          child:  Padding(padding: EdgeInsets.all(10),
          child:  FutureBuilder<Timetable>(
       future: timetable,
       builder: (context, snapshot) {

         if (snapshot.hasData) {
          return ListView.builder(
            itemCount: prog!=null?snapshot.data!.data.where((element) => 
            element.studentId==prog && element.day==dy).toList().length:1,
            itemBuilder: prog!=null? (context, index) {
              List<Datum> dataa=snapshot.data!.data.where((element) => 
              element.studentId==prog && element.day==dy).toList();

              String venue=dataa[index].venue;
              String time=dataa[index].time;
              String instructor=dataa[index].instructor;
              String course=dataa[index].course;
            
                  var arr=time.split("-");
    var noww=DateTime.now();
    var splitted_now=noww.toString().split(" ");
    var splitted_now2=noww.toString().split(" ");
    var dttt1;
     var dttt2;
     var dttttt1;
     var dttttt2;
     var category;

      arr[1]="${arr[1]}:00";
      arr[0]="${arr[0].replaceAll(' ', '')}:00";
       splitted_now2[1]=arr[1];
       dttt1=splitted_now2;
         splitted_now[1]=arr[0];
         dttt2=splitted_now;
        dttttt1=dttt1[0]+""+dttt1[1];
         dttttt2=dttt2[0]+" "+dttt2[1];
        DateTime dt1=DateTime.parse(dttttt1);
        DateTime dt2=DateTime.parse(dttttt2);
        Duration durr=dt1.difference(dt2);
         String dayy;
               WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

        setState(() {
           
            sessions=dataa.length;
                if(tutoriallls<=sessions && lectures<=sessions && labbs<sessions &&
                 (labbs+tutoriallls+lectures)<sessions){
              if(durr.inMinutes<120 && 
              !venue.toLowerCase().contains("lab")){
         
               if(dataa[index].day==1){
                     if(prog==1){
       putData("Monday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==2){
       putData("Monday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==3){
       putData("Monday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Tutorial", time, '3');
                     }
         if(prog==4){
       putData("Monday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==5){
       putData("Monday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==6){
       putData("Monday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==7){
       putData("Monday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '4');
                     }
             if(prog==8){
       putData("Monday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==9){
       putData("Monday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==10){
       putData("Monday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==11){
       putData("Monday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '4');
                     }
             if(prog==12){
       putData("Monday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==13){
       putData("Monday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==14){
       putData("Monday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==15){
       putData("Monday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '4');
                     }
         if(prog==16){
       putData("Monday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==17){
       putData("Monday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==18){
       putData("Monday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Tutorial", time, '3');
                     }
              if(prog==19){
       putData("Monday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==20){
       putData("Monday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==21){
       putData("Monday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Tutorial", time, '3');
                     } 
             if(prog==22){
       putData("Monday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==23){
       putData("Monday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==24){
       putData("Monday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==25){
       putData("Monday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '4');
                     } 
           if(prog==26){
       putData("Monday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==27){
       putData("Monday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==28){
       putData("Monday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Tutorial", time, '3');
                     } 
             if(prog==29){
       putData("Monday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==30){
       putData("Monday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==31){
       putData("Monday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Tutorial", time, '3');
                     }       
                }
         if(dataa[index].day==2){
                     if(prog==1){
       putData("Tuesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==2){
       putData("Tuesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==3){
       putData("Tuesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Tutorial", time, '3');
                     }
           if(prog==4){
       putData("Tuesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==5){
       putData("Tuesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==6){
       putData("Tuesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==7){
       putData("Tuesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '4');
                     }
               if(prog==8){
       putData("Tuesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==9){
       putData("Tuesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==10){
       putData("Tuesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==11){
       putData("Tuesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '4');
                     }
             if(prog==12){
       putData("Tuesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==13){
       putData("Tuesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==14){
       putData("Tuesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==15){
       putData("Tuesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '4');
                     }
         if(prog==16){
       putData("Tuesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==17){
       putData("Tuesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==18){
       putData("Tuesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Tutorial", time, '3');
                     }
              if(prog==19){
       putData("Tuesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==20){
       putData("Tuesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==21){
       putData("Tuesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Tutorial", time, '3');
                     } 
             if(prog==22){
       putData("Tuesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==23){
       putData("Tuesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==24){
       putData("Tuesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==25){
       putData("Tuesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '4');
                     } 
           if(prog==26){
       putData("Tuesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==27){
       putData("Tuesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==28){
       putData("Tuesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Tutorial", time, '3');
                     } 
             if(prog==29){
       putData("Tuesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==30){
       putData("Tuesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==31){
       putData("Tuesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Tutorial", time, '3');
                     }  
                    
                }
        if(dataa[index].day==3){
                     if(prog==1){
       putData("Wednesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==2){
       putData("Wednesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==3){
       putData("Wednesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Tutorial", time, '3');
                     }
          if(prog==4){
       putData("Wednesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==5){
       putData("Wednesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==6){
       putData("Wednesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==7){
       putData("Wednesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '4');
                     }
               if(prog==8){
       putData("Wednesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==9){
       putData("Wednesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==10){
       putData("Wednesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==11){
       putData("Wednesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '4');
                     }
             if(prog==12){
       putData("Wednesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==13){
       putData("Wednesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==14){
       putData("Wednesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==15){
       putData("Wednesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '4');
                     }
         if(prog==16){
       putData("Wednesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==17){
       putData("Wednesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==18){
       putData("Wednesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Tutorial", time, '3');
                     }
              if(prog==19){
       putData("Wednesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==20){
       putData("Wednesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==21){
       putData("Wednesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Tutorial", time, '3');
                     } 
             if(prog==22){
       putData("Wednesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==23){
       putData("Wednesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==24){
       putData("Wednesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==25){
       putData("Wednesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '4');
                     } 
           if(prog==26){
       putData("Wednesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==27){
       putData("Wednesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==28){
       putData("Wednesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Tutorial", time, '3');
                     } 
             if(prog==29){
       putData("Wednesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==30){
       putData("Wednesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==31){
       putData("Wednesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Tutorial", time, '3');
                     } 
                    
                }
                 if(dataa[index].day==4){
                     if(prog==1){
       putData("Thursday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==2){
       putData("Thursday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==3){
       putData("Thursday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Tutorial", time, '3');
                     }
        if(prog==4){
       putData("Thursday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==5){
       putData("Thursday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==6){
       putData("Thursday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==7){
       putData("Thursday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '4');
                     }
         if(prog==8){
       putData("Thursday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==9){
       putData("Thursday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==10){
       putData("Thursday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==11){
       putData("Thursday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '4');
                     }
             if(prog==12){
       putData("Thursday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==13){
       putData("Thursday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==14){
       putData("Thursday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==15){
       putData("Thursday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '4');
                     }
         if(prog==16){
       putData("Thursday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==17){
       putData("Thursday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==18){
       putData("Thursday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Tutorial", time, '3');
                     }
              if(prog==19){
       putData("Thursday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==20){
       putData("Thursday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==21){
       putData("Thursday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Tutorial", time, '3');
                     } 
             if(prog==22){
       putData("Thursday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==23){
       putData("Thursday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==24){
       putData("Thursday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==25){
       putData("Thursday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '4');
                     } 
           if(prog==26){
       putData("Thursday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==27){
       putData("Thursday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==28){
       putData("Thursday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Tutorial", time, '3');
                     } 
             if(prog==29){
       putData("Thursday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==30){
       putData("Thursday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==31){
       putData("Thursday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Tutorial", time, '3');
                     } 
                    
                }
                 if(dataa[index].day==5){
               if(prog==1){
       putData("Friday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==2){
       putData("Friday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==3){
       putData("Friday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==4){
       putData("Friday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==5){
       putData("Friday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==6){
       putData("Friday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==7){
       putData("Friday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Tutorial", time, '4');
                     }
               if(prog==8){
       putData("Friday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==9){
       putData("Friday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==10){
       putData("Friday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==11){
       putData("Friday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Tutorial", time, '4');
                     }
             if(prog==12){
       putData("Friday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==13){
       putData("Friday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==14){
       putData("Friday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==15){
       putData("Friday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Tutorial", time, '4');
                     }
         if(prog==16){
       putData("Friday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==17){
       putData("Friday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==18){
       putData("Friday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Tutorial", time, '3');
                     }
              if(prog==19){
       putData("Friday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==20){
       putData("Friday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==21){
       putData("Friday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Tutorial", time, '3');
                     } 
             if(prog==22){
       putData("Friday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '1');
                     }
               if(prog==23){
       putData("Friday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '2');
                     }
               if(prog==24){
       putData("Friday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '3');
                     }
             if(prog==25){
       putData("Friday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Tutorial", time, '4');
                     } 
           if(prog==26){
       putData("Friday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==27){
       putData("Friday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==28){
       putData("Friday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Tutorial", time, '3');
                     } 
             if(prog==29){
       putData("Friday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Tutorial", time, '1');
                     }
             if(prog==30){
       putData("Friday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Tutorial", time, '2');
                     }
             if(prog==31){
       putData("Friday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Tutorial", time, '3');
                     } 
                    
                }
              
                tutoriallls++;
                }
              
               if(venue.toLowerCase().contains("lab")){
        if(dataa[index].day==1){
                     if(prog==1){
       putData("Monday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Labaratory", time, '1');
                     }
               if(prog==2){
       putData("Monday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Labaratory", time, '2');
                     }
               if(prog==3){
       putData("Monday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Labaratory", time, '3');
                     }
            if(prog==4){
       putData("Monday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '1');
                     }
               if(prog==5){
       putData("Monday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '2');
                     }
               if(prog==6){
       putData("Monday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '3');
                     }
             if(prog==7){
       putData("Monday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '4');
                     }
                      if(prog==8){
       putData("Monday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Labaratory", time, '1');
                     }
               if(prog==9){
       putData("Monday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Labaratory", time, '2');
                     }
               if(prog==10){
       putData("Monday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Labaratory", time, '3');
                     }
             if(prog==11){
       putData("Monday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Labaratory", time, '4');
                     }
             if(prog==12){
       putData("Monday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Labaratory", time, '1');
                     }
               if(prog==13){
       putData("Monday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Labaratory", time, '2');
                     }
               if(prog==14){
       putData("Monday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Labaratory", time, '3');
                     }
             if(prog==15){
       putData("Monday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Labaratory", time, '4');
                     }
         if(prog==16){
       putData("Monday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Labaratory", time, '1');
                     }
             if(prog==17){
       putData("Monday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Labaratory", time, '2');
                     }
             if(prog==18){
       putData("Monday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Labaratory", time, '3');
                     }
              if(prog==19){
       putData("Monday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Labaratory", time, '1');
                     }
             if(prog==20){
       putData("Monday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Labaratory", time, '2');
                     }
             if(prog==21){
       putData("Monday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Labaratory", time, '3');
                     } 
             if(prog==22){
       putData("Monday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Labaratory", time, '1');
                     }
               if(prog==23){
       putData("Monday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Labaratory", time, '2');
                     }
               if(prog==24){
       putData("Monday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Labaratory", time, '3');
                     }
             if(prog==25){
       putData("Monday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Labaratory", time, '4');
                     } 
           if(prog==26){
       putData("Monday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Labaratory", time, '1');
                     }
             if(prog==27){
       putData("Monday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Labaratory", time, '2');
                     }
             if(prog==28){
       putData("Monday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Labaratory", time, '3');
                     } 
             if(prog==29){
       putData("Monday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Labaratory", time, '1');
                     }
             if(prog==30){
       putData("Monday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Labaratory", time, '2');
                     }
             if(prog==31){
       putData("Monday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Labaratory", time, '3');
                     }   
                    
                }
         if(dataa[index].day==2){
                     if(prog==1){
       putData("Tuesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Labaratory", time, '1');
                     }
               if(prog==2){
       putData("Tuesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Labaratory", time, '2');
                     }
               if(prog==3){
       putData("Tuesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Labaratory", time, '3');
                     }
             if(prog==4){
       putData("Tuesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '1');
                     }
               if(prog==5){
       putData("Tuesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '2');
                     }
               if(prog==6){
       putData("Tuesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '3');
                     }
             if(prog==7){
       putData("Tuesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '4');
                     }
                                           if(prog==8){
       putData("Tuesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Labaratory", time, '1');
                     }
               if(prog==9){
       putData("Tuesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Labaratory", time, '2');
                     }
               if(prog==10){
       putData("Tuesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Labaratory", time, '3');
                     }
             if(prog==11){
       putData("Tuesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Labaratory", time, '4');
                     }
             if(prog==12){
       putData("Tuesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Labaratory", time, '1');
                     }
               if(prog==13){
       putData("Tuesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Labaratory", time, '2');
                     }
               if(prog==14){
       putData("Tuesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Labaratory", time, '3');
                     }
             if(prog==15){
       putData("Tuesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Labaratory", time, '4');
                     }
         if(prog==16){
       putData("Tuesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Labaratory", time, '1');
                     }
             if(prog==17){
       putData("Tuesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Labaratory", time, '2');
                     }
             if(prog==18){
       putData("Tuesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Labaratory", time, '3');
                     }
              if(prog==19){
       putData("Tuesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Labaratory", time, '1');
                     }
             if(prog==20){
       putData("Tuesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Labaratory", time, '2');
                     }
             if(prog==21){
       putData("Tuesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Labaratory", time, '3');
                     } 
             if(prog==22){
       putData("Tuesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Labaratory", time, '1');
                     }
               if(prog==23){
       putData("Tuesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Labaratory", time, '2');
                     }
               if(prog==24){
       putData("Tuesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Labaratory", time, '3');
                     }
             if(prog==25){
       putData("Tuesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Labaratory", time, '4');
                     } 
           if(prog==26){
       putData("Tuesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Labaratory", time, '1');
                     }
             if(prog==27){
       putData("Tuesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Labaratory", time, '2');
                     }
             if(prog==28){
       putData("Tuesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Labaratory", time, '3');
                     } 
             if(prog==29){
       putData("Tuesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Labaratory", time, '1');
                     }
             if(prog==30){
       putData("Tuesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Labaratory", time, '2');
                     }
             if(prog==31){
       putData("Tuesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Labaratory", time, '3');
                     }  
                    
                }
        if(dataa[index].day==3){
                     if(prog==1){
       putData("Wednesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Labaratory", time, '1');
                     }
               if(prog==2){
       putData("Wednesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Labaratory", time, '2');
                     }
               if(prog==3){
       putData("Wednesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Labaratory", time, '3');
                     }
                   if(prog==4){
       putData("Wednesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '1');
                     }
               if(prog==5){
       putData("Wednesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '2');
                     }
               if(prog==6){
       putData("Wednesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '3');
                     }
             if(prog==7){
       putData("Wednesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '4');
                     }
         if(prog==8){
       putData("Wednesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Laboratory", time, '1');
                     }
               if(prog==9){
       putData("Wednesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Laboratory", time, '2');
                     }
               if(prog==10){
       putData("Wednesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Laboratory", time, '3');
                     }
             if(prog==11){
       putData("Wednesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Laboratory", time, '4');
                     }
             if(prog==12){
       putData("Wednesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Laboratory", time, '1');
                     }
               if(prog==13){
       putData("Wednesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Laboratory", time, '2');
                     }
               if(prog==14){
       putData("Wednesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Laboratory", time, '3');
                     }
             if(prog==15){
       putData("Wednesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Laboratory", time, '4');
                     }
         if(prog==16){
       putData("Wednesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Laboratory", time, '1');
                     }
             if(prog==17){
       putData("Wednesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Laboratory", time, '2');
                     }
             if(prog==18){
       putData("Wednesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Laboratory", time, '3');
                     }
              if(prog==19){
       putData("Wednesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Laboratory", time, '1');
                     }
             if(prog==20){
       putData("Wednesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Laboratory", time, '2');
                     }
             if(prog==21){
       putData("Wednesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Laboratory", time, '3');
                     } 
             if(prog==22){
       putData("Wednesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Laboratory", time, '1');
                     }
               if(prog==23){
       putData("Wednesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Laboratory", time, '2');
                     }
               if(prog==24){
       putData("Wednesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Laboratory", time, '3');
                     }
             if(prog==25){
       putData("Wednesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Laboratory", time, '4');
                     } 
           if(prog==26){
       putData("Wednesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Laboratory", time, '1');
                     }
             if(prog==27){
       putData("Wednesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Laboratory", time, '2');
                     }
             if(prog==28){
       putData("Wednesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Laboratory", time, '3');
                     } 
             if(prog==29){
       putData("Wednesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Laboratory", time, '1');
                     }
             if(prog==30){
       putData("Wednesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Laboratory", time, '2');
                     }
             if(prog==31){
       putData("Wednesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Laboratory", time, '3');
                     }  
                    
                }
                 if(dataa[index].day==4){
                     if(prog==1){
       putData("Thursday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Labaratory", time, '1');
                     }
               if(prog==2){
       putData("Thursday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Labaratory", time, '2');
                     }
               if(prog==3){
       putData("Thursday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Labaratory", time, '3');
                     }
             if(prog==4){
       putData("Thursday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '1');
                     }
               if(prog==5){
       putData("Thursday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '2');
                     }
               if(prog==6){
       putData("Thursday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '3');
                     }
             if(prog==7){
       putData("Thursday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '4');
                     }
           if(prog==8){
       putData("Thursday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Laboratory", time, '1');
                     }
               if(prog==9){
       putData("Thursday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Laboratory", time, '2');
                     }
               if(prog==10){
       putData("Thursday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Laboratory", time, '3');
                     }
             if(prog==11){
       putData("Thursday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Laboratory", time, '4');
                     }
             if(prog==12){
       putData("Thursday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Laboratory", time, '1');
                     }
               if(prog==13){
       putData("Thursday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Laboratory", time, '2');
                     }
               if(prog==14){
       putData("Thursday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Laboratory", time, '3');
                     }
             if(prog==15){
       putData("Thursday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Laboratory", time, '4');
                     }
         if(prog==16){
       putData("Thursday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Laboratory", time, '1');
                     }
             if(prog==17){
       putData("Thursday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Laboratory", time, '2');
                     }
             if(prog==18){
       putData("Thursday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Laboratory", time, '3');
                     }
              if(prog==19){
       putData("Thursday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Laboratory", time, '1');
                     }
             if(prog==20){
       putData("Thursday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Laboratory", time, '2');
                     }
             if(prog==21){
       putData("Thursday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Laboratory", time, '3');
                     } 
             if(prog==22){
       putData("Thursday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Laboratory", time, '1');
                     }
               if(prog==23){
       putData("Thursday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Laboratory", time, '2');
                     }
               if(prog==24){
       putData("Thursday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Laboratory", time, '3');
                     }
             if(prog==25){
       putData("Thursday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Laboratory", time, '4');
                     } 
           if(prog==26){
       putData("Thursday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Laboratory", time, '1');
                     }
             if(prog==27){
       putData("Thursday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Laboratory", time, '2');
                     }
             if(prog==28){
       putData("Thursday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Laboratory", time, '3');
                     } 
             if(prog==29){
       putData("Thursday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Laboratory", time, '1');
                     }
             if(prog==30){
       putData("Thursday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Laboratory", time, '2');
                     }
             if(prog==31){
       putData("Thursday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Laboratory", time, '3');
                     }  
                    
                    
                }
                 if(dataa[index].day==5){
                     if(prog==1){
       putData("Friday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Labaratory", time, '1');
                     }
               if(prog==2){
       putData("Friday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Labaratory", time, '2');
                     }
               if(prog==3){
       putData("Friday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Labaratory", time, '3');
                     }
              if(prog==4){
       putData("Friday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '1');
                     }
               if(prog==5){
       putData("Friday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '2');
                     }
               if(prog==6){
       putData("Friday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '3');
                     }
             if(prog==7){
       putData("Friday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Labaratory", time, '4');
                     }
                            if(prog==8){
       putData("Friday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Laboratory", time, '1');
                     }
               if(prog==9){
       putData("Friday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Laboratory", time, '2');
                     }
               if(prog==10){
       putData("Friday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Laboratory", time, '3');
                     }
             if(prog==11){
       putData("Friday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Laboratory", time, '4');
                     }
             if(prog==12){
       putData("Friday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Laboratory", time, '1');
                     }
               if(prog==13){
       putData("Friday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Laboratory", time, '2');
                     }
               if(prog==14){
       putData("Friday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Laboratory", time, '3');
                     }
             if(prog==15){
       putData("Friday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Laboratory", time, '4');
                     }
         if(prog==16){
       putData("Friday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Laboratory", time, '1');
                     }
             if(prog==17){
       putData("Friday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Laboratory", time, '2');
                     }
             if(prog==18){
       putData("Friday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Laboratory", time, '3');
                     }
              if(prog==19){
       putData("Friday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Laboratory", time, '1');
                     }
             if(prog==20){
       putData("Friday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Laboratory", time, '2');
                     }
             if(prog==21){
       putData("Friday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Laboratory", time, '3');
                     } 
             if(prog==22){
       putData("Friday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Laboratory", time, '1');
                     }
               if(prog==23){
       putData("Friday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Laboratory", time, '2');
                     }
               if(prog==24){
       putData("Friday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Laboratory", time, '3');
                     }
             if(prog==25){
       putData("Friday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Laboratory", time, '4');
                     } 
           if(prog==26){
       putData("Friday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Laboratory", time, '1');
                     }
             if(prog==27){
       putData("Friday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Laboratory", time, '2');
                     }
             if(prog==28){
       putData("Friday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Laboratory", time, '3');
                     } 
             if(prog==29){
       putData("Friday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Laboratory", time, '1');
                     }
             if(prog==30){
       putData("Friday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Laboratory", time, '2');
                     }
             if(prog==31){
       putData("Friday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Laboratory", time, '3');
                     } 
                    
                }
                  labbs++;
                }
                if(durr.inMinutes>=120 && !venue.toLowerCase().contains("lab")){
                    if(dataa[index].day==1){
         if(prog==1){
       putData("Monday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==2){
       putData("Monday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==3){
       putData("Monday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==4){
       putData("Monday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==5){
       putData("Monday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==6){
       putData("Monday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==7){
       putData("Monday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '4');
                     }
                 if(prog==8){
       putData("Monday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==9){
       putData("Monday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==10){
       putData("Monday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==11){
       putData("Monday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '4');
                     }
             if(prog==12){
       putData("Monday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==13){
       putData("Monday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==14){
       putData("Monday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==15){
       putData("Monday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '4');
                     }
         if(prog==16){
       putData("Monday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==17){
       putData("Monday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==18){
       putData("Monday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Lecture", time, '3');
                     }
              if(prog==19){
       putData("Monday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==20){
       putData("Monday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==21){
       putData("Monday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Lecture", time, '3');
                     } 
             if(prog==22){
       putData("Monday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==23){
       putData("Monday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==24){
       putData("Monday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==25){
       putData("Monday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '4');
                     } 
           if(prog==26){
       putData("Monday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==27){
       putData("Monday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==28){
       putData("Monday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Lecture", time, '3');
                     } 
             if(prog==29){
       putData("Monday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==30){
       putData("Monday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==31){
       putData("Monday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Lecture", time, '3');
                     }  
                    
                }
         if(dataa[index].day==2){
                     if(prog==1){
       putData("Tuesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==2){
       putData("Tuesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==3){
       putData("Tuesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Lecture", time, '3');
                     }
          if(prog==4){
       putData("Tuesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==5){
       putData("Tuesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==6){
       putData("Tuesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==7){
       putData("Tuesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '4');
                     }
                         if(prog==8){
       putData("Tuesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==9){
       putData("Tuesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==10){
       putData("Tuesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==11){
       putData("Tuesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '4');
                     }
             if(prog==12){
       putData("Tuesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==13){
       putData("Tuesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==14){
       putData("Tuesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==15){
       putData("Tuesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '4');
                     }
         if(prog==16){
       putData("Tuesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==17){
       putData("Tuesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==18){
       putData("Tuesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Lecture", time, '3');
                     }
              if(prog==19){
       putData("Tuesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==20){
       putData("Tuesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==21){
       putData("Tuesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Lecture", time, '3');
                     } 
             if(prog==22){
       putData("Tuesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==23){
       putData("Tuesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==24){
       putData("Tuesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==25){
       putData("Tuesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '4');
                     } 
           if(prog==26){
       putData("Tuesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==27){
       putData("Tuesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==28){
       putData("Tuesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Lecture", time, '3');
                     } 
             if(prog==29){
       putData("Tuesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==30){
       putData("Tuesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==31){
       putData("Tuesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Lecture", time, '3');
                     }  
                    
                }
        if(dataa[index].day==3){
                     if(prog==1){
       putData("Wednesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==2){
       putData("Wednesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==3){
       putData("Wednesday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Lecture", time, '3');
                     }
         if(prog==4){
       putData("Wednesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==5){
       putData("Wednesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==6){
       putData("Wednesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==7){
       putData("Wednesday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '4');
                     }
                                 if(prog==8){
       putData("Wednesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==9){
       putData("Wednesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==10){
       putData("Wednesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==11){
       putData("Wednesday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '4');
                     }
             if(prog==12){
       putData("Wednesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==13){
       putData("Wednesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==14){
       putData("Wednesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==15){
       putData("Wednesday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '4');
                     }
         if(prog==16){
       putData("Wednesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==17){
       putData("Wednesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==18){
       putData("Wednesday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Lecture", time, '3');
                     }
              if(prog==19){
       putData("Wednesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==20){
       putData("Wednesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==21){
       putData("Wednesday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Lecture", time, '3');
                     } 
             if(prog==22){
       putData("Wednesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==23){
       putData("Wednesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==24){
       putData("Wednesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==25){
       putData("Wednesday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '4');
                     } 
           if(prog==26){
       putData("Wednesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==27){
       putData("Wednesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==28){
       putData("Wednesday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Lecture", time, '3');
                     } 
             if(prog==29){
       putData("Wednesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==30){
       putData("Wednesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==31){
       putData("Wednesday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Lecture", time, '3');
                     }  
                    
                }
                 if(dataa[index].day==4){
                     if(prog==1){
       putData("Thursday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==2){
       putData("Thursday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==3){
       putData("Thursday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Lecture", time, '3');
                     }
            if(prog==4){
       putData("Thursday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==5){
       putData("Thursday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==6){
       putData("Thursday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==7){
       putData("Thursday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '4');
                     }
                                                     if(prog==8){
       putData("Thursday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==9){
       putData("Thursday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==10){
       putData("Thursday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==11){
       putData("Thursday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '4');
                     }
             if(prog==12){
       putData("Thursday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==13){
       putData("Thursday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==14){
       putData("Thursday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==15){
       putData("Thursday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '4');
                     }
         if(prog==16){
       putData("Thursday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==17){
       putData("Thursday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==18){
       putData("Thursday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Lecture", time, '3');
                     }
              if(prog==19){
       putData("Thursday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==20){
       putData("Thursday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==21){
       putData("Thursday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Lecture", time, '3');
                     } 
             if(prog==22){
       putData("Thursday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==23){
       putData("Thursday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==24){
       putData("Thursday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==25){
       putData("Thursday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '4');
                     } 
           if(prog==26){
       putData("Thursday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==27){
       putData("Thursday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==28){
       putData("Thursday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Lecture", time, '3');
                     } 
             if(prog==29){
       putData("Thursday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==30){
       putData("Thursday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==31){
       putData("Thursday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Lecture", time, '3');
                     }  
                    
                }
                 if(dataa[index].day==5){
                     if(prog==1){
       putData("Friday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==2){
       putData("Friday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==3){
       putData("Friday", widget.semister, widget.college, "BCs-CS", course, venue, instructor, "Lecture", time, '3');
                     }
            if(prog==4){
       putData("Friday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==5){
       putData("Friday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==6){
       putData("Friday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==7){
       putData("Friday", widget.semister, widget.college, "BCs-SE", course, venue, instructor, "Lecture", time, '4');
                     }
                                               if(prog==8){
       putData("Friday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==9){
       putData("Friday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==10){
       putData("Friday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==11){
       putData("Friday", widget.semister, widget.college, "BCs-TE", course, venue, instructor, "Lecture", time, '4');
                     }
             if(prog==12){
       putData("Friday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==13){
       putData("Friday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==14){
       putData("Friday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==15){
       putData("Friday", widget.semister, widget.college, "BCs-CNISE", course, venue, instructor, "Lecture", time, '4');
                     }
         if(prog==16){
       putData("Friday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==17){
       putData("Friday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==18){
       putData("Friday", widget.semister, widget.college, "BCs-HIS", course, venue, instructor, "Lecture", time, '3');
                     }
              if(prog==19){
       putData("Friday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==20){
       putData("Friday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==21){
       putData("Friday", widget.semister, widget.college, "BCs-BIS", course, venue, instructor, "Lecture", time, '3');
                     } 
             if(prog==22){
       putData("Friday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '1');
                     }
               if(prog==23){
       putData("Friday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '2');
                     }
               if(prog==24){
       putData("Friday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '3');
                     }
             if(prog==25){
       putData("Friday", widget.semister, widget.college, "BCs-CE", course, venue, instructor, "Lecture", time, '4');
                     } 
           if(prog==26){
       putData("Friday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==27){
       putData("Friday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==28){
       putData("Friday", widget.semister, widget.college, "BCs-MTA", course, venue, instructor, "Lecture", time, '3');
                     } 
             if(prog==29){
       putData("Friday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Lecture", time, '1');
                     }
             if(prog==30){
       putData("Friday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Lecture", time, '2');
                     }
             if(prog==31){
       putData("Friday", widget.semister, widget.college, "BCs-IS", course, venue, instructor, "Lecture", time, '3');
                     } 
                    
                }
                  lectures++;
                }
              }
              });
                });

    
              
            return OverallTimetableCard(null, venue, time, instructor, course,null);
          }:(context, index) => const Text("Currently no data is Available")
          );
    } 
    else if (snapshot.hasError) {
       List<String>? collgs=all_timetable!.get("colleges");
       List<String>? proggggs=all_timetable!.get("programmes");
       List<String>? yerrrs=all_timetable!.get("years");
       List<String>? semmms=all_timetable!.get("semisters");
       List<String>? venyuuuuuus=all_timetable!.get("venues");
       List<String>? lectureees=all_timetable!.get("lectures");
       List<String>? tymesss=all_timetable!.get("times");
       List<String>? dayyys=all_timetable!.get("days");
       List<String>? categoryyyys=all_timetable!.get("categories");
       List<String>? coursesss=all_timetable!.get("courses");
       List<String> venues=[];
       List<String> lectresss=[];
       List<String> cozeee=[];
       List<String> tymmm=[];
       List<String> cat=[];
       if(proggggs!=null){
       List<String> filteredProgs=proggggs.where((element) => element==widget.programme,).toList();
       List<String> filtereddays=dayyys!.where((element) => element==widget.day,).toList();
       List<String> filteredyrs=yerrrs!.where((element) => element==widget.year.toString(),).toList();
       List<String> filteredsemsts=semmms!.where((element) => element==widget.semister,).toList();
          if(filteredProgs.isNotEmpty){
           print("inafika................................ days ${filtereddays.length}");
           print("inafika................................ sems ${filteredsemsts.length}");
           print("inafika................................ years ${filteredyrs.length}");
           print("inafika................................ progs ${filteredProgs.length}");
   
          }
          if(filtereddays.isNotEmpty && filteredyrs.isNotEmpty){
          for(var d=0;d<dayyys.length;d++){
          //   print("day... ${filtereddays[d]}");
          //  print("years.. ${filteredyrs[d]}");
          //  print("progs.. ${filteredProgs[d]}");
          //  print("course....... ${filtereddays}");
            if(proggggs[d]==widget.programme && dayyys[d]==widget.day
             && semmms[d]==widget.semister && yerrrs[d]==widget.year.toString()){
               venues.add(venyuuuuuus![d]);
               tymmm.add(tymesss![d]);
               lectresss.add(lectureees![d]);
               cozeee.add(coursesss![d]);
               cat.add(categoryyyys![d]);
             }
          else{
            print("empty....................................");
          }
       }
          }
    
       }
      return cozeee.isNotEmpty && venues.isNotEmpty?ListView.builder(
        itemCount: cozeee.length,
        itemBuilder: (context, index) {
          String venue=venues[index];
          String time=tymmm[index];
          String instructor=lectresss[index];
          String course=cozeee[index];
          String categ=cat[index];
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            setState(() {
              sessions=cozeee.length;
                   if(tutoriallls<=sessions && lectures<=sessions && labbs<sessions &&
                 (labbs+tutoriallls+lectures)<sessions){
                    if(categ=="Tutorial"){
                      tutoriallls++;
                    }
                      if(categ=="Lecture"){
                      lectures++;
                    }
                    if(categ=="Labaratory"){
                      labbs++;
                    }
                 }
            });
           });
        return OverallTimetableCard(null, venue, time, instructor, course,categ);
      },
      ):const Text("No Data is Available");
    }
   

    // By default, show a loading spinner.
    return const SizedBox(width: 20,height: 50,child: CircularProgressIndicator(),) ;
          },
            )
      )
      )

      ],)
    );
  }
}

