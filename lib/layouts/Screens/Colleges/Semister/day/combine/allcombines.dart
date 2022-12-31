import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/combine/cobine_card.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/combine/desc2.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import '../../../../../../main.dart';


class AllCombine extends StatefulWidget {
  const AllCombine({super.key});

  @override
  State<AllCombine> createState() => _AllCombineState();
}

class _AllCombineState extends State<AllCombine> {
   Color favourate=Colors.white;
  SharedPreferences? sharedPreferences;
  bool? myfavourate;
  int? notify;
   Future getPreference() async{
         sharedPreferences=await SharedPreferences.getInstance();
         setState(() {
          myfavourate=sharedPreferences!.getBool("favourate");  
             notify=sharedPreferences!.getInt("notify");
                                  AndroidAlarmManager.periodic(const Duration(seconds: 60),1,callbackDispatcher,params: {
    "combine":myfavourate,
    "notify":notify,
     "c_programes":progs,
    "c_colleges":colleges,
    "c_years":yrs,
    "c_semister":sems,
    "c_venues":venyus,
    "c_days":dayss,
    "c_t_from":time_froms,
    "c_t_to":tymes,
    "c_cozes":cozes,
    "c_instructs":instructs
   },rescheduleOnReboot: true,wakeup: true,exact: true);
         });
       
     }
   Future<void> setPreference(bool value) async{
  sharedPreferences=await SharedPreferences.getInstance();
   sharedPreferences!.setBool("favourate", value);
     }

  Box<List<String>>? combinebox;
  @override
  void initState() {
    getPreference();
    combinebox=Hive.box<List<String>>("combine");
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
                List<String>? instructs;

 void actionOnCombines(String option) {
  if(option=="Delete"){
    showDialog(context: context, builder: (context) {
      return Dialog(
      
        child: Container(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(padding: EdgeInsets.all(20),

              child: Center(child:Text("Are You Sure You Want To Delete All Combines",
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
      combinebox!.delete("colleges");
      combinebox!.delete("programmes");
      combinebox!.delete("years");
      combinebox!.delete("semisters");
      combinebox!.delete("days");
      combinebox!.delete("venues");
      combinebox!.delete("time_to");
      combinebox!.delete("courses");
      combinebox!.delete("time_from");
      combinebox!.delete("instructors");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All Combines Deleted")));  
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
 
     combinebox=Hive.box<List<String>>("combine");
    setState(() {
      colleges=combinebox!.get("colleges"); 
     progs=combinebox!.get("programmes"); 
      yrs=combinebox!.get("years"); 
       sems=combinebox!.get("semisters"); 
        venyus=combinebox!.get("venues"); 
         dayss=combinebox!.get("days"); 
          time_froms=combinebox!.get("time_from"); 
           tymes=combinebox!.get("time_to"); 
            cozes=combinebox!.get("courses"); 
            instructs=combinebox!.get("instructors");
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
        title:new Text("Created Combines"),
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
          onSelected:actionOnCombines,
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
         venyus==null || venyus!.isEmpty? Center(child: Text("No Previews Yet"),): Description2(),
           Expanded(
          flex: 1,
          child:  Padding(padding: EdgeInsets.all(10),
          child: venyus==null || venyus!.isEmpty?
          Center(child:Text("No Combines Created")):
          ListView.builder(
            itemCount: venyus!.length,
            itemBuilder: (context, index) {
              return CombineCard(null, tymes![index], cozes![index], venyus![index],
               "Lecture", time_froms![index],dayss![index],
               colleges![index],progs![index],sems![index],yrs![index],instructs![index]);
             
          },)
      )
      )

        ],
        ),
    );
  }
}