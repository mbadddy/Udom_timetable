
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/Screens/Home.dart';
import 'package:udom_timetable/layouts/Screens/notification/notification.dart';
import 'package:udom_timetable/layouts/Screens/notification/promodoroTimer.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import '../../main.dart';


class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
    SharedPreferences? sharedPreferences;
   String? favourate;
  Future getPreferences() async{
    sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      favourate=sharedPreferences!.getString("college")!;
    });
  }
  int? notify;
    Future setNotification(int minutes) async{

    sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences!.setInt("notify", minutes);
     }
   Future getNotification() async{
    sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
       notify=sharedPreferences!.getInt("notify");
    });
   
     }

 //by day
 List<String>? coll;
  List<String>? prog;
  List<String>? yea;
  List<String>? sem;
  List<String>? day;
  bool? combine;
  bool? exam;
  Future getByDay() async{
       sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
         coll=sharedPreferences!.getStringList("colleges"); 
          prog=sharedPreferences!.getStringList("programes");
           yea=sharedPreferences!.getStringList("years");
            sem=sharedPreferences!.getStringList("semisters");
             day=sharedPreferences!.getStringList("days"); 
             combine=sharedPreferences!.getBool("favourate"); 
             exam=sharedPreferences!.getBool("e_favourate");
    });
 }

//end
int _value = 1;
List<int> minutes=[30,20,15,10,5];

restoreNotify(){
  if(notify!=null){
    setState(() {
    if(notify==30){
      _value=1;
    }
     if(notify==20){
      _value=2;
    }
      
       if(notify==15){
      _value=3;
    }
       if(notify==10){
      _value=4;
    }
       if(notify==5){
      _value=5;
    }
    });
  }
}
getAlarmProcess(minutes){
  if(Platform.isAndroid){
                                                    AndroidAlarmManager.periodic(const Duration(seconds: 60),1,callbackDispatcher,params: {
    "combine":combine,
    "notify":minutes,
    "c_programes":c_progs,
    "c_colleges":c_colleges,
    "c_years":c_yrs,
    "c_semister":c_sems,
    "c_venues":c_venyus,
    "c_days":c_dayss,
    "c_t_from":c_time_froms,
    "c_t_to":c_tymes,
    "c_cozes":c_cozes,
    "c_instructs":c_instructs
   },rescheduleOnReboot: true,wakeup: true,exact: true);
        AndroidAlarmManager.periodic(const Duration(seconds: 60),3,callBackExam,params: {
    "exam":exam,
    "notify":minutes,
     "e_programes":e_progs,
    "e_colleges":e_colleges,
    "e_years":e_yrs,
    "e_semister":e_sems,
    "e_venues":e_venyus,
    "e_days":e_dayss,
    "e_t_from":e_time_froms,
    "e_t_to":e_tymes,
    "e_cozes":e_cozes,
   },rescheduleOnReboot: true,wakeup: true,exact: true);
  }
}
 showMenu() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
                    height: (56 * 7).toDouble(),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                          color: appbarc,
                        ),
                        child: Stack(
                          alignment: Alignment(0, 0),
                          // Overflow: Overflow.visible,
                          children: <Widget>[
                            Positioned(
                              top: -36,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    border: Border.all(
                                        color:appbarc, width: 10)),
                                child: const Center(
                                  child: ClipOval(
                                    child:  Text("hello")
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                   
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  const Padding(padding: EdgeInsets.all(40),
                                  child: Text("Set Notification Before",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  ),
                                  for (int i = 1; i <= minutes.length; i++)
                                             
                                               RadioListTile(
                                                  title: Text(
                                                  '${minutes[i-1]} Minutes',
                                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                                ),
                                                  value: i,
                                                  groupValue: _value,
                                                  activeColor: Color(0xFF6200EE),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _value=value!;
                                                      Navigator.pop(context);
                                                      showMenu();
                                                      setNotification(minutes[i-1]);
                                                       getNotification();
                                                     getAlarmProcess(minutes[i-1]);
                                                      print("value ${_value}...............");
                                                    });
                                                  },
                                                ),
                                             
                                              
                                ],
                              ),
                            )
                          ],
                        )));
        
        });
  }

 Box<List<String>>? combinebox;
 Box<List<String>>? exambox;



  late final PromodoroTimer service;


    @override
  void initState() {
    service=PromodoroTimer();
    // 
    getByDay();
   getPreferences();
   getNotification();
   getSwitchOn();
   restoreNotify();
    combinebox=Hive.box<List<String>>("combine");
    exambox=Hive.box<List<String>>("Exams");
    super.initState();
  }


  List<String>? c_colleges;
  List<String>? c_progs;
    List<String>? c_yrs;
      List<String>? c_sems;
        List<String>? c_cozes;
          List<String>? c_venyus;
            List<String>? c_dayss;
              List<String>? c_time_froms;
                List<String>? c_tymes;
                List<String>? c_instructs;

//axams
 List<String>? e_colleges;
  List<String>? e_progs;
    List<String>? e_yrs;
      List<String>? e_sems;
        List<String>? e_cozes;
          List<String>? e_venyus;
            List<String>? e_dayss;
              List<String>? e_time_froms;
                List<String>? e_tymes;

  bool checker=false;
  bool? isSwitchedd;
  bool isSwitched = false;  
  Future setSwitchOn(bool isSwitchedd)async{
    sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences!.setBool("isSwiched", isSwitchedd);
  }
   Future getSwitchOn()async{
    sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      isSwitchedd=sharedPreferences!.getBool("isSwiched");
    });
  }
  void toggleSwitch(bool value) {  
  
    if(isSwitched == false)  
    {  
      setState(() {  
        isSwitched = true; 
        setSwitchOn(isSwitched);
        getSwitchOn(); 
        setNotification(30);
        getNotification();
        restoreNotify();
      });  
    }  
    else  
    {  
      setState(() {  
        isSwitched = false;  
        setSwitchOn(isSwitched);
        getSwitchOn();
        removeTimeOnSwitchOff(); 
      });  
    } 
    if(isSwitched){
      showMenu();
    } 
  }  
  Future removeTimeOnSwitchOff()async{
     sharedPreferences=await SharedPreferences.getInstance();
     sharedPreferences!.remove("notify");
  }
    Color appbarc=const Color.fromARGB(255, 16, 82, 100);


  @override
  Widget build(BuildContext context) { 
    // handleBackgroudNotification();
    DateTime date=DateTime.now();
    print('today is ${DateFormat.EEEE().format(date)} time ${DateFormat.Hm().format(date)}..........................');
    if(combine==true){
       setState(() {
         c_colleges=combinebox!.get("colleges"); 
         c_progs=combinebox!.get("programmes"); 
         c_yrs=combinebox!.get("years"); 
         c_sems=combinebox!.get("semisters"); 
         c_venyus=combinebox!.get("venues"); 
         c_dayss=combinebox!.get("days"); 
         c_time_froms=combinebox!.get("time_from"); 
         c_tymes=combinebox!.get("time_to"); 
         c_cozes=combinebox!.get("courses"); 
         c_instructs=combinebox!.get("instructors");
            // instructors
    });
    print("combine days...................${c_dayss}");
    print("combine semisters...................${c_sems}");
    print("combine programs...................${c_progs}");
    print("combine colleges...................${c_colleges}");
    print("combine years...................${c_yrs}");
    print("combine venues...................${c_venyus}");
    print("combine instructors...................${c_sems}");
    print("combine times from...................${c_time_froms}");
    print("combine times to...................${c_tymes}");
    print("combine courses...................${c_cozes}");
    } 

 if(exam==true){
       setState(() {
         e_colleges=exambox!.get("e_colleges"); 
         e_progs=exambox!.get("e_programmes"); 
         e_yrs=exambox!.get("e_years"); 
         e_sems=exambox!.get("e_semisters"); 
         e_venyus=exambox!.get("e_venues"); 
         e_dayss=exambox!.get("e_days"); 
         e_time_froms=exambox!.get("e_time_from"); 
         e_tymes=exambox!.get("e_time_to"); 
         e_cozes=exambox!.get("e_courses"); 
            // instructors
    });
    }
//  String? college;
//  String? programe;
//  String? year;
//  String? semist;
 //by day

   if(day!=null){
    print("days...................${day}");
    print("semisters...................${sem}");
    print("programs...................${prog}");
    print("colleges...................${coll}");
    print("years...................${yea}");
   }

   if(notify!=null){
      
      print("notification is before ${notify}");
   }
   else{
    print("imeshakuwa null");
   }
   restoreNotify();
 final ThemeData mode = Theme.of(context);
 var whichMode=mode.brightness;
if(whichMode==Brightness.dark){
  setState(() {
          appbarc=Colors.black12;
      });
     }
    return Scaffold(
       appBar: AppBar(

        title:const Text("Notification"),
        
        backgroundColor: appbarc,
        actions: [
  
        ],
        
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                  Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notification',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
             Switch(
                  onChanged: toggleSwitch,
                value: isSwitchedd ?? isSwitched,  
              activeColor: Colors.blue,  
              activeTrackColor: Colors.yellow,  
              inactiveThumbColor: Colors.redAccent,  
              inactiveTrackColor: Colors.orange,  
                
              ),
            ],
          ),
        ),
        const Divider(),
        ],
      )
  
    );
  }
  
  void listernToNotification(String payload) {
     NotificationService().onclickNotifiation.stream.listen((event) {
    if(payload!=null && payload.isNotEmpty){
      print(payload);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications(),));
    }
  });
  }
}
