// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import 'package:udom_timetable/layouts/Screens/Colleges/Semister/Semister.dart';
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
  




Color all_days_color=Colors.white;

 Box<List<String>>? all_timetable;
@override
  void initState() {
      all_timetable=Hive.box<List<String>>("timetable");
      // getAllCheckers();
    // all_timetable!.deleteAll(all_timetable!.keys);
    // cclearData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    List<Widget> tabview4=[
                           Semist(year:1, college: widget.college, programme: widget.programe,),
                           Semist(year:2,college: widget.college, programme: widget.programe, ),
                           Semist(year:3,college: widget.college, programme: widget.programe,),
                           Semist(year:4,college: widget.college, programme: widget.programe,),
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