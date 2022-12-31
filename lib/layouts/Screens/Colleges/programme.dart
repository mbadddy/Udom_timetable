// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:udom_timetable/layouts/Screens/Colleges/Semister/Semister.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/timetable.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/programe_card_detail.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
class Programme extends StatefulWidget {
  String programe;
  String college;
  int year;
  String subtitle;
  Programme({
    Key? key,
    required this.programe,
    required this.college,
    required this.year,
    required this.subtitle,
  }) : super(key: key);

  @override
  State<Programme> createState() => _ProgrammeState();
}

class _ProgrammeState extends State<Programme> {
  List<Widget> childrens=[];
  List<Tab> tabs4=[
       Tab(text: 'First Year'),
       Tab(text: 'Second Year'),
       Tab(text: 'Third Year'),
       Tab(text: 'Final Year'),
  ];
   int yr=0;
  

 SharedPreferences? sharedPreferences;
 Future setAllDaysColor(String college,String programe) async{

      sharedPreferences=await SharedPreferences.getInstance();
      sharedPreferences!.setString("a_coll", college);
      sharedPreferences!.setString("a_prog", programe);

     
 }
 Future checkTruth(bool truth)async{
 
  sharedPreferences=await SharedPreferences.getInstance();
     sharedPreferences!.setBool("truth",truth);
 }
bool? all_days;
Color all_days_color=Colors.white;

String? prog;
String? yer;
String? sem;
String? coll;
Future<void> getAllDayTableData() async{
  sharedPreferences=await SharedPreferences.getInstance();
  setState(() {
  prog=sharedPreferences!.getString("a_prog");
  yer=sharedPreferences!.getString("a_year");
  sem=sharedPreferences!.getString("a_sem");
  coll=sharedPreferences!.getString("a_coll");
  all_days=sharedPreferences!.getBool("truth");
  });
  
}
Future<void> removeAllDayTableData() async{

  sharedPreferences=await SharedPreferences.getInstance();
  sharedPreferences!.remove("a_prog");
  sharedPreferences!.remove("a_year");
  sharedPreferences!.remove("a_sem");
  sharedPreferences!.remove("a_coll");
  sharedPreferences!.remove("truth");

}
Future cclearData() async{
  sharedPreferences=await SharedPreferences.getInstance();
  sharedPreferences!.clear();
}
 Box<List<String>>? all_timetable;
@override
  void initState() {
      all_timetable=Hive.box<List<String>>("timetable");
    // all_timetable!.deleteAll(all_timetable!.keys);
    // cclearData();
    getAllDayTableData();
    super.initState();
  }
   bool? weekly;
  @override
  Widget build(BuildContext context) {
    
      if(all_days!=null){
        setState(() {
         if(all_days==true){
          
           if(sharedPreferences!=null){
             
           
            if(prog==widget.programe && coll==widget.college){
              
             
               all_days_color=Colors.red;
             }
           }
         }
         else{
        
          all_days_color=Colors.white;
         }
        });
      }
      else{
        setState(() {
          all_days=false;
          all_days_color=Colors.white;
        });
      }
//  getAllDayTableData();
   print("truth is "+all_days.toString());
   setState(() {
   
     if(prog!=null){
      print("sio null");
     }
       if(prog==widget.programe){
         weekly=true;
        }
      else{
         weekly=false;
        }
    });

    List<Widget> tabview4=[
                           Semist(year:1, college: widget.college, programme: widget.programe, a_prog: weekly!,),
                           Semist(year:2,college: widget.college, programme: widget.programe, a_prog: weekly!),
                           Semist(year:3,college: widget.college, programme: widget.programe, a_prog: weekly!),
                           Semist(year:4,college: widget.college, programme: widget.programe, a_prog: weekly!),
    ];
    setState(() {
          if(widget.year==3){
            if(tabs4.length==4){
           tabview4.removeWhere((element) => element==tabview4[3]);
           tabs4.removeWhere((element) => element==tabs4[3]);
           tabs4[2]=Tab(text: 'Final Year');
            }
           
          }
       else{
         tabs4;
       }
    });
   
   Color appbar=appColr;
   Color indicator=Colors.black;
   Color unselected=Colors.black26;
   final ThemeData mode = Theme.of(context);
   var whichMode=mode.brightness;
   if(whichMode==Brightness.dark){
  setState(() {
          appbar=Colors.black12;
          indicator=Colors.white;
          unselected=Colors.white38;
      });
}

 print(widget.college);
    return Scaffold(
        appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: () {
          Navigator.of(context).pop();
        },),
        centerTitle: true,
        title:new Text(widget.programe),
        
        backgroundColor: appbar,
        actions: [
        IconButton(
          color: all_days_color,
          onPressed: () {
          setState(() {
           if(all_days==true){
              all_days=false;
             
              all_days_color=Colors.white;
               checkTruth(all_days!);
               removeAllDayTableData();
             setState(() {
               weekly=false; 
                getAllDayTableData();
              });
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Storage Optimized for "+prog!+" press again to move in "+widget.programe+" year "+yer!+" semister "+sem!)));
          }
          else{
               all_days=true;
               
               all_days_color=Colors.red;
              setAllDaysColor(widget.college, widget.programe);
              checkTruth(all_days!);
              setState(() {
               weekly=true; 
               getAllDayTableData();
              });
               
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(widget.college+" "+widget.programe+" "+yer!+" "+sem!
                +" Added to favourates")));
          } 
         
          });
          
        }, icon: Icon(Icons.star_border_outlined))
        ],
        
      ),
      body: SingleChildScrollView(
              child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              UserDetailCard(subtile: widget.subtitle, title: widget.programe, years: widget.year,),
              DefaultTabController(
                length: widget.year, // length of tabs
                initialIndex: 0,
                
                child: Builder(builder: (context) {
              
          
                  return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Container(
                        child: TabBar(
                         
                          labelColor: indicator,
                          unselectedLabelColor: unselected,
                          indicatorColor: indicator,
                          tabs: tabs4
                       
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.68, //height of TabBarView
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: TabBarView(
                        children: tabview4
                      ),
                    ),
                  ],
                );
                },)
                
                
              
              ),
            ],
          ),
      ),
    );
  }
}