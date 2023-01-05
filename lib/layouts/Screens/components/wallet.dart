// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/Screens/components/wallet_icons.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? course;
  String? time;
  String? dayy;
   String? venue;
  String? lecture;
  SharedPreferences? sharedPreferences;
  Future<void> getData()async{
    sharedPreferences=await SharedPreferences.getInstance();

    setState(() {
    course=sharedPreferences!.getString("h_course");
    time=sharedPreferences!.getString("h_time");
    dayy=sharedPreferences!.getString("h_day");
        venue=sharedPreferences!.getString("h_venue");
    lecture=sharedPreferences!.getString("h_lecture");
    });
    
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
   String status='';
   popup(){
    showDialog(context: context,builder: (context) {
      return Dialog(child:Padding(padding: EdgeInsets.all(20),
      
      child: Container(
        height: 200,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(105),),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Session Details",style: TextStyle(fontWeight: FontWeight.bold),),
          Text("Course: $course"),
         Text("Time: $time"),
         Text("Venue: $venue"),
         Text("Lecture: $lecture"),
         
         ],
      ),)
      ));
    },);
   }
  @override
  Widget build(BuildContext context) {  
      getData(); 
      getData(); 
        DateTime day=DateTime.now();
        String today=DateFormat.EEEE().format(day);
     String td_time=DateFormat.Hm().format(day);
     if(time!=null){
      var arr1=time!.split("-");
      


      var noww=DateTime.now();
      var splitted_now=noww.toString().split(" ");
      var splitted_now2=noww.toString().split(" ");
      var dttt1;
      var dttt2;
      var dttttt1;
      var dttttt2;
      var category;
      var c_time="${arr1[0].replaceAll(" ",'')}:00";
      td_time="${td_time}";
   
       splitted_now2[1]=c_time;
       dttt1=splitted_now2;
       splitted_now[1]=td_time;
       dttt2=splitted_now;
      dttttt1=dttt1[0]+" "+dttt1[1];
      dttttt2=dttt2[0]+" "+dttt2[1];
      DateTime dt1=DateTime.parse(dttttt1);
      DateTime dt2=DateTime.parse(dttttt2);
      Duration durr=dt1.difference(dt2);


      setState(() {
        if(durr.inMinutes > 0 && today==dayy){
                status="Active";
        }
        else{
                status="Expired";
        }
      });
     }
    
     Color appbar=appColr;
     ThemeData deco=ThemeData.dark();
     Color deco2=Colors.white;
     final ThemeData mode = Theme.of(context);
    var whichMode=mode.brightness;
    if(whichMode==Brightness.dark){
     setState(() {
          appbar=Colors.black12;
          deco2=Colors.black45;
      });
}
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: appbar,
          borderRadius: BorderRadius.circular(25),
        ),
        height: 105,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: SingleChildScrollView(
                reverse: true,
                // physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
               
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0,top: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: deco2,
                        ),
                        height: 75,
                        width: 125,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children:  [
                                    const Icon(
                                      Icons.notifications_active,
                                      size: 18,
                                      color: Colors.blue,
                                    ),
                                    const Text(
                                      'Today',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 15,),
                                    course==null? Text("wait..",style: TextStyle(color: appColr,fontSize: 10),):
                                   status=='Expired'?const Text("expired",style: TextStyle(color: Colors.red,fontSize: 10),):
                                  const Text("Active",style: TextStyle(color: Colors.green,fontSize: 10),)
                                  ],
                                ),
                             
                               course==null ?const Text("No data"): Text('${course}'),
                                time==null? const Text("No Data"):  Text('$time'),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    GestureDetector(
          onTap: () {
             popup();
          },
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              size: 30,
              Icons.remove_red_eye_outlined,
              color: Color(0xff0081A0),
            ),
          ),
               ),
                  const SizedBox(
          height: 10,
        ),
        const Text(
         "View",
          style: TextStyle(color: Colors.white),
        )
              ],),         
            const WallerrIcons(icons: Icons.add, text: 'Combine', category: 'combine',),
            const WallerrIcons(icons: Icons.add, text: 'Exams', category: 'exams',),
           
          ],
        ),
      ),
    );
  }
}
