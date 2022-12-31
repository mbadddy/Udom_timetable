// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/Actual_ratiba/overall.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/programme.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/services/Modal/timetable.dart';
import 'package:udom_timetable/services/timetable_Service.dart';

class Day extends StatefulWidget {
  String title;
  String semister;
  String college;
  String programme;
  int year;
  bool a_prog;
  Day({
    Key? key,
    required this.title,
    required this.semister,
    required this.college,
    required this.programme,
    required this.year,
    required this.a_prog,
  }) : super(key: key);

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  SharedPreferences? sharedPreferences;
  
//set day Data to shared
  Future setDayData(String college,String programe,int year,String semister,String day) async{
    sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences!.setString("colllege", college);
     sharedPreferences!.setString("programme", programe);
      sharedPreferences!.setInt("year", year);
       sharedPreferences!.setString("semister", semister);
       List<String> days=[];
       List<String> colleges=[];
       List<String> semisters=[];
       List<String> years=[];
       List<String> programmes=[];
         if(sharedPreferences!.getStringList('days')==null){
           days.add(day);
           sharedPreferences!.setStringList("days", days);
         }
         else{
          
            List<String>? dayss=sharedPreferences!.getStringList('days');
            days.add(day);
            for(var d=0;d<dayss!.length;d++)
            {
              print(dayss[d].toString()+" added");
            days.add(dayss[d].toString());
            }
           sharedPreferences!.setStringList("days", days);
         }
          
        if(sharedPreferences!.getStringList('programes')==null){
           programmes.add(programe);
           sharedPreferences!.setStringList("programes", programmes);
         }
         else{
          
            List<String>? prog=sharedPreferences!.getStringList('programes');
            programmes.add(programe);
            for(var d=0;d<prog!.length;d++)
            {
              print(prog[d].toString()+" added");
            programmes.add(prog[d].toString());
            }
           sharedPreferences!.setStringList("programes", programmes);
         }
       if(sharedPreferences!.getStringList('colleges')==null){
           colleges.add(college);
           sharedPreferences!.setStringList("colleges", colleges);
         }
         else{
          
            List<String>? coll=sharedPreferences!.getStringList('colleges');
            colleges.add(college);
            for(var d=0;d<coll!.length;d++)
            {
              print(coll[d].toString()+" added");
               colleges.add(coll[d].toString());
            }
           sharedPreferences!.setStringList("colleges", colleges);
         }
     if(sharedPreferences!.getStringList('semisters')==null){
           semisters.add(semister);
           sharedPreferences!.setStringList("semisters", semisters);
         }
         else{
          
            List<String>? sem=sharedPreferences!.getStringList('semisters');
            semisters.add(semister);
            for(var d=0;d<sem!.length;d++)
            {
              print(sem[d].toString()+" added");
               semisters.add(sem[d].toString());
            }
           sharedPreferences!.setStringList("semisters", semisters);
         }
     if(sharedPreferences!.getStringList('years')==null){
           years.add(year.toString());
           sharedPreferences!.setStringList("years", years);
         }
         else{
            List<String>? ye=sharedPreferences!.getStringList('years');
            years.add(year.toString());
            for(var d=0;d<ye!.length;d++)
            {
              print(ye[d].toString()+" added");
               years.add(ye[d].toString());
            }
           sharedPreferences!.setStringList("years", years);
         }
          
       
  }
Future setAction(bool act,String day)async{
   sharedPreferences=await SharedPreferences.getInstance();
   if(day=="Monday"){
     sharedPreferences!.setBool("favourate1", act);
     print("imewekwa monday "+sharedPreferences!.getBool("favourate1").toString());
   }
    if(day=="Tuesday"){
     sharedPreferences!.setBool("favourate2", act);
   }
    if(day=="Wednesday"){
     sharedPreferences!.setBool("favourate3", act);
   }
    if(day=="Thursday"){
     sharedPreferences!.setBool("favourate4", act);
   }
    if(day=="Friday"){
     sharedPreferences!.setBool("favourate5", act);
   }
  

}
  Future removeDayData(String day,String semist,String college,String year,String programme) async{
    sharedPreferences=await SharedPreferences.getInstance();
       var days=sharedPreferences!.getStringList("days")??[];
       for(var dy=0;dy<days.length;dy++){
        if(days[dy]==day){
            days.removeWhere((element) => element==day);
            sharedPreferences!.setStringList('days', days);
        }
       }
       var years=sharedPreferences!.getStringList("years")??[];
      
         for(var yr=0;yr<days.length;yr++){
        if(years[yr]==year){
             years.removeWhere((element) => element==semist);
            sharedPreferences!.setStringList('years', years);
        }
       }
     var semisters=sharedPreferences!.getStringList("semisters")??[];
       semisters.removeWhere((element) => element==semist);
         for(var sem=0;sem<semisters.length;sem++){
        if(semisters[sem]==semist){
            semisters.removeWhere((element) => element==semist);
            sharedPreferences!.setStringList('semisters', semisters);
        }
       }
       
      var colleges=sharedPreferences!.getStringList("colleges")??[];
       
         for(var col=0;col<colleges.length;col++){
        if(colleges[col]==college){
           colleges.removeWhere((element) => element==college);
            sharedPreferences!.setStringList('colleges', colleges);
        }
       }
        var programes=sharedPreferences!.getStringList("programes")??[];
       
         for(var p=0;p<programes.length;p++){
        if(days[p]==programme){
              programes.removeWhere((element) => element==programme);
            sharedPreferences!.setStringList('programes', programes);
        }
       }
     
        if(day=="Monday"){
          sharedPreferences!.remove("favourate1");
        }
        if(day=="Tuesday"){
          sharedPreferences!.remove("favourate2");
        }
         if(day=="Wednesday"){
          sharedPreferences!.remove("favourate3");
        }
          if(day=="Thursday"){
          sharedPreferences!.remove("favourate4");
        }
      if(day=="Friday"){
          sharedPreferences!.remove("favourate5");
        }


 
  }

  //get day data from shared
  List<String>? colleges;
   List<String>? programes;
    List<String>? semisters;
    List<String>? dayy;
     List<String>? years;
     bool? favourate1;
      bool? favourate2;
       bool? favourate3;
        bool? favourate4;
         bool? favourate5;

     bool? overall;    
 Future<void> getDayData() async{
   sharedPreferences=await SharedPreferences.getInstance();
   setState(() {
     colleges=sharedPreferences!.getStringList("colleges");
     programes=sharedPreferences!.getStringList("programes");
     dayy=sharedPreferences!.getStringList("days");
     semisters=sharedPreferences!.getStringList("semisters");
     years=sharedPreferences!.getStringList("years");
     favourate1=sharedPreferences!.getBool('favourate1');
     favourate2=sharedPreferences!.getBool('favourate2');
     favourate3=sharedPreferences!.getBool('favourate3');
     favourate4=sharedPreferences!.getBool('favourate4');
     favourate5=sharedPreferences!.getBool('favourate5');
   });
 }


  Color favourate_default=Colors.white;
  void detector(){
    
}
Future detector2() async{
       sharedPreferences=await SharedPreferences.getInstance();
       sharedPreferences!.clear();
}

//service started




@override
  void initState() {
    
     getDayData();
     detector();
    //  detector2();
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    //  getDayData();
    //check if favourates is null
    if(favourate1==null){
      print("Favourate1 ni null");
      setState(() {
         favourate1=false;
         favourate_default=Colors.white;
      });
    
    }
        if(favourate2==null){
      print("Favourate2 ni null");
      setState(() {
         favourate2=false;
         favourate_default=Colors.white;
      });
    
    }
        if(favourate3==null){
      print("Favourate3 ni null");
      setState(() {
         favourate3=false;
         favourate_default=Colors.white;
      });
    
    }
        if(favourate4==null){
      print("Favourate4 ni null");
      setState(() {
         favourate4=false;
         favourate_default=Colors.white;
      });
    
    }
        if(favourate5==null){
      print("Favourate5 ni null");
      setState(() {
         favourate5=false;
         favourate_default=Colors.white;
      });
    
    }
    //

   //check and assign right page 
     if(dayy!=null && colleges!=null){
      for(var col=0;col<colleges!.length;col++){
        
         if(colleges![col]==widget.college && semisters![col]==widget.semister && years![col]==widget.year.toString() &&
          dayy![col]==widget.title && programes![col]==widget.programme
         ){
                 if(widget.title=="Monday"){
                                                                                if(favourate1==true){
                                                                                   print("Value for Favourate Monday "+favourate1.toString());
                                                                              setState(() {
                                                                                favourate_default=Colors.red;
                                                                              
                                                                              });
                                                                            }
                                                                                else{
                                                                                  print("monday false");
                                                                                  setState(() {
                                                                                    favourate_default=Colors.white;
                                                                                });
                                                                                }
                                                                                                                        }
                                                          if(widget.title=="Tuesday"){
                                                                        if(favourate2==true){
                                                                        print("Tuesday true");
                                                                          setState(() {
                                                                            favourate_default=Colors.red;
                                                                          
                                                                          });
                                                                        }
                                                                        else{
                                                                        print("Tuesday false");
                                                                        setState(() {
                                                                          favourate_default=Colors.white;
                                                                      });
                                                                      }
                                                          }

                                                    if(widget.title=="Wednesday"){
                                                            if(favourate3==true){
                                                            print("Wednesday true");
                                                              setState(() {
                                                                favourate_default=Colors.red;
                                                              
                                                              });
                                                            }
                                                              else{
                                                              print("Wednesday false");
                                                              setState(() {
                                                                favourate_default=Colors.white;
                                                            });
                                                            }
                                                    }
                                                        if(widget.title=="Thursday"){
                                                                  if(favourate4==true){
                                                                    print("Thursday true");
                                                                      setState(() {
                                                                        favourate_default=Colors.red;
                                                                      
                                                                      });
                                                                    }
                                                                    else{
                                                                      print("Thursday false");
                                                                      setState(() {
                                                                        favourate_default=Colors.white;
                                                                    });
                                                                    }
                                                        }

      
                                                if(widget.title=="Friday"){
                                                      if(favourate5==true){
                                                        print("Friday true");
                                                          setState(() {
                                                            favourate_default=Colors.red;
                                                          
                                                          });
                                                        }
                                                        else{
                                                          print("Friday false");
                                                          setState(() {
                                                            favourate_default=Colors.white;
                                                        });
                                                        }
                                            }
         }
                                  else{
                            print("not right day");
     
                                     }
                             }
                     }
              
   //
                                  if(dayy!=null){
                                    for(int x=0;x<dayy!.length;x++){
                                      print("day "+dayy![x]);
                                    }
                                    
                                  }
                                  Color appbar=appColr;
                            
                            final ThemeData mode = Theme.of(context);
                          var whichMode=mode.brightness;
                          if(whichMode==Brightness.dark){
                            setState(() {
                                    appbar=Colors.black12;
                                });
                            }
 
    
print("iliyofika "+widget.a_prog.toString());
 
    return Scaffold(
       appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: () {
          Navigator.of(context).pop();
        },),
        centerTitle: true,
        title:new Text(widget.title),
        
        
        backgroundColor: appbar,
        actions: [
          Padding(padding: EdgeInsets.only(right: 10),
          child:IconButton(
            isSelected: widget.a_prog,
            color: favourate_default,
            onPressed: widget.a_prog==true? null :() {
          setState(() {
                  if(widget.title=="Monday"){
                    print("monday ");
                       if(favourate1==true){
                        favourate1=false;
                        setAction(favourate1!,widget.title);
                           for(var col=0;col<colleges!.length;col++){
                                if(colleges![col]==widget.college && semisters![col]==widget.semister && years![col]==widget.year.toString() &&
                                dayy![col]==widget.title && programes![col]==widget.programme
                        ){
                              
                                 removeDayData(widget.title,widget.semister,widget.college,widget.year.toString(),widget.programme);
                                    }
                }

                        favourate_default=Colors.white;
                     }
                     else{
                        favourate1=true;
                        setAction(favourate1!,widget.title);
                        setState(() {
                            setDayData(widget.college, widget.programme, widget.year, widget.semister, widget.title);
                        });
                        favourate_default=Colors.red;
                     }
                  }
                   if(widget.title=="Tuesday"){
                    print("Tuesday");
                       if(favourate2==true){
                        favourate2=false;
                        setAction(favourate2!,widget.title);
                     for(var col=0;col<colleges!.length;col++){
                 if(colleges![col]==widget.college && semisters![col]==widget.semister && years![col]==widget.year.toString() &&
          dayy![col]==widget.title && programes![col]==widget.programme
         ){
                    print(widget.college+" inatolewa");
                    removeDayData(widget.title,widget.semister,widget.college,widget.year.toString(),widget.programme);
                 }
                }
         
                        favourate_default=Colors.white;
                     }
                     else{
                        favourate2=true;
                        setAction(favourate2!,widget.title);
                        setState(() {
                            setDayData(widget.college, widget.programme, widget.year, widget.semister, widget.title);
                        });
                        favourate_default=Colors.red;
                     }
                  }
                   if(widget.title=="Wednesday"){
                    print("Wednesday");
                       if(favourate3==true){
                        favourate3=false;
                        setAction(favourate3!,widget.title);
                         
                             for(var col=0;col<colleges!.length;col++){
      if(colleges![col]==widget.college && semisters![col]==widget.semister && years![col]==widget.year.toString() &&
          dayy![col]==widget.title && programes![col]==widget.programme
         ){
         print(widget.college+" inatolewa");
      removeDayData(widget.title,widget.semister,widget.college,widget.year.toString(),widget.programme);
                 }
                }
         
                        favourate_default=Colors.white;
                     }
                     else{
                        favourate3=true;
                        setAction(favourate1!,widget.title);
                        setState(() {
                            setDayData(widget.college, widget.programme, widget.year, widget.semister, widget.title);
                        });
                      
                        favourate_default=Colors.red;
                     }
                  }
                   if(widget.title=="Thursday"){
                    print("Thursday");
                       if(favourate4==true){
                        favourate4=false;
                        setAction(favourate4!,widget.title);
                        print("waiting for delete..........");
                           for(var col=0;col<colleges!.length;col++){
                            print("college: "+colleges![col]+" compare "+widget.college);
              print("Semister: "+semisters![col]+" compare "+widget.semister);
            print("year: "+years![col]+" compare "+widget.year.toString());
                  print("day: "+dayy![col]+" compare "+widget.title);
              print("programme: "+programes![col]+" compare "+widget.programme);
      if(colleges![col]==widget.college && semisters![col]==widget.semister && years![col]==widget.year.toString() &&
          dayy![col]==widget.title && programes![col]==widget.programme
         ){
      removeDayData(widget.title,widget.semister,widget.college,widget.year.toString(),widget.programme);
                 }
                }
     
                        favourate_default=Colors.white;
                     }
                     else{
                        favourate4=true;
                        setAction(favourate4!,widget.title);
                         setState(() {
                            setDayData(widget.college, widget.programme, widget.year, widget.semister, widget.title);
                        });
                        favourate_default=Colors.red;
                     }
                  }
                       if(widget.title=="Friday"){
                  
                       if(favourate5==true){
                        favourate5=false;
                        setAction(favourate5!,widget.title);
                        
                           for(var col=0;col<colleges!.length;col++){
                     if(colleges![col]==widget.college && semisters![col]==widget.semister && years![col]==widget.year.toString() &&
                       dayy![col]==widget.title && programes![col]==widget.programme
                       ){
                        print("ipo yakufuta "+widget.title);
                       removeDayData(widget.title,widget.semister,widget.college,widget.year.toString(),widget.programme);
                 }
                }
                     favourate_default=Colors.white;
                     setState(() {
                         getDayData();  
                     });
                     }
                     else{
                        favourate5=true;
                        setAction(favourate5!,widget.title);
                         setState(() {
                            setDayData(widget.college, widget.programme, widget.year, widget.semister, widget.title);
                              getDayData();  
                        });
                        favourate_default=Colors.red;
                     }
                  }
                   

          });
         
       }, icon: Icon(Icons.star_border)),)
      
        ],
        
      ),
      body: OverallAttendance(day: widget.title, semister: widget.semister, year: widget.year,programme: widget.programme, college: widget.college,),
    );
  }
}