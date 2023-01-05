import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/Exams_Tests/desc2.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/combine/cobine_card.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/combine/desc2.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import '../../../../../../main.dart';
import 'E_ts_card.dart';


class AllExams extends StatefulWidget {
  const AllExams({super.key});

  @override
  State<AllExams> createState() => _AllExamsState();
}

class _AllExamsState extends State<AllExams> {
   Color favourate=Colors.white;
  SharedPreferences? sharedPreferences;
  bool? myfavourate;
  int? notify;
   Future getPreference() async{
         sharedPreferences=await SharedPreferences.getInstance();
         setState(() {
          myfavourate=sharedPreferences!.getBool("e_favourate");  
             notify=sharedPreferences!.getInt("notify");
                                  AndroidAlarmManager.periodic(const Duration(seconds: 60),3,callBackExam,params: {
    "exam":myfavourate,
    "notify":notify,
     "e_programes":progs,
    "e_colleges":colleges,
    "e_years":yrs,
    "e_semister":sems,
    "e_venues":venyus,
    "e_days":dayss,
    "e_t_from":time_froms,
    "e_t_to":tymes,
    "e_cozes":cozes,
   },rescheduleOnReboot: true,wakeup: true,exact: true);
         });
       
     }
   Future<void> setPreference(bool value) async{
  sharedPreferences=await SharedPreferences.getInstance();
   sharedPreferences!.setBool("e_favourate", value);
     }

  Box<List<String>>? exambox;
  @override
  void initState() {
    getPreference();
    exambox=Hive.box<List<String>>("Exams");
    // combinebox!.deleteAll(combinebox!.keys);
    super.initState();
  }
  List<String>? colleges;
  List<String>? progs;
    List<String>? yrs;
      List<String>? sems;
        List<String>? cozes;
          List<String>? venyus;
            List<String>? dayss;
              List<String>? time_froms;
                List<String>? tymes;
                List<String>? categorys;

 void actionOnExams(String option) {
  if(option=="Delete"){
    showDialog(context: context, builder: (context) {
      return Dialog(
      
        child: Container(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(padding: EdgeInsets.all(20),

              child: Center(child:Text("Are You Sure You Want To Delete All Exams",
              style: TextStyle(fontWeight: FontWeight.bold),)),),
             
              SizedBox(height: 3,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(padding: EdgeInsets.all(10),
                  child: ElevatedButton(onPressed: () {
                     clearCombines();
                     Navigator.pop(context);
                      Navigator.pop(context);
                  }, child: Text("Yes")),)
                  ,
                  Padding(padding: EdgeInsets.all(10),
                  child: ElevatedButton(onPressed: () {
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deletion Exited")));  
                    Navigator.pop(context);
                     
                  }, child: Text("No")),)
                   
                ],
              )
            ],
          ),
        ),
      );
    },);
  }
  }
  void clearCombines(){
 
   if(colleges!=null){
      exambox!.delete("e_colleges");
      exambox!.delete("e_programmes");
      exambox!.delete("e_years");
      exambox!.delete("e_semisters");
      exambox!.delete("e_days");
      exambox!.delete("e_venues");
      exambox!.delete("e_time_to");
      exambox!.delete("e_courses");
      exambox!.delete("e_time_from");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All Exams Deleted")));  
    }
  }
  List<String> options=["Delete","Waiting"];
  @override
  Widget build(BuildContext context) {
    getPreference();
        
    if(myfavourate!=null){
      print("fref "+myfavourate.toString());
      if(myfavourate==true){
        setState(() {
          favourate=Colors.red;
         
        });
      }
      else{
        setState(() {
          favourate=Colors.white;
        
                });
      }
      
        }
        else{
        myfavourate=false;
        print("pref imewekwa ");
        }
 
     exambox=Hive.box<List<String>>("Exams");
    setState(() {
      colleges=exambox!.get("e_colleges"); 
     progs=exambox!.get("e_programmes"); 
      yrs=exambox!.get("e_years"); 
       sems=exambox!.get("e_semisters"); 
        venyus=exambox!.get("e_venues"); 
         dayss=exambox!.get("e_days"); 
          time_froms=exambox!.get("e_time_from"); 
           tymes=exambox!.get("e_time_to");
           categorys=exambox!.get("e_categorys");
            cozes=exambox!.get("e_courses"); //e_categorys
            // instructors
    });
    if(colleges==null || colleges!.isEmpty)
    {
     setState(() {
       options.remove("Delete");
     });
    }
    
 Color appbar=appColr;
 final ThemeData mode = Theme.of(context);
 var whichMode=mode.brightness;
if(whichMode==Brightness.dark){
  setState(() {
          appbar=Colors.black12;
      });
}
    return Scaffold(
           appBar: AppBar(
        centerTitle: true,
        title:new Text("Created Exams"),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: () {
          Navigator.of(context).pop();
        },),
        backgroundColor: appbar,
        actions: [
          IconButton(
             color: favourate,
            onPressed: () {
            setState(() {
                     if(myfavourate==null || myfavourate==true){
                     myfavourate=false;
                    
                    setPreference(myfavourate!);
                     }
                     else{
                       myfavourate=true;
                
                      setPreference(myfavourate!);
                     }
                 
                    
                  });
          }, icon: Icon(Icons.star_border)),
      PopupMenuButton(
          position: PopupMenuPosition.under,
          onSelected:actionOnExams,
          itemBuilder: (context) => 
        
         options.map((String option) {
              return PopupMenuItem<String>(
                 value: option,
                child: Text(option),
              );
            }).toList(),
        )
        ],
        
      ),
      body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         venyus==null || venyus!.isEmpty? Center(child: Text("No Previews Yet"),): Desc2(),
           Expanded(
          flex: 1,
          child:  Padding(padding: EdgeInsets.all(10),
          child: venyus==null || venyus!.isEmpty?
          Center(child:Text("No Exams Created")):
          ListView.builder(
            itemCount: venyus!.length,
            itemBuilder: (context, index) {
              return ExamCard(null, tymes![index], cozes![index], venyus![index],
              time_froms![index],dayss![index],
               colleges![index],progs![index],sems![index],yrs![index],categorys![index]);
             
          },)
      )
      )

        ],
        ),
    );
  }
}