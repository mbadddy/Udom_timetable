// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:udom_timetable/layouts/Screens/Colleges/Semister/timetable.dart';

class Semist extends StatefulWidget {
  int year;
  String programme;
  String college;
  Semist({
    Key? key,
    required this.year,
    required this.programme,
    required this.college,
  }) : super(key: key);

  @override
  State<Semist> createState() => _SemistState();
}

class _SemistState extends State<Semist> {
    final String title = 'Semister'.tr;
   String dropdownvalue = 'ONE';
  // final LanguageController _languageController = Get.find();
final List<String> lang=["ONE","TWO"];


 SharedPreferences? sharedPreferences;
 Future setAllDaysColor(String year,String sem) async{
      sharedPreferences=await SharedPreferences.getInstance();
      sharedPreferences!.setString("a_year", year);
      sharedPreferences!.setString("a_sem", sem);
 }
  Future removeAllDaysColor() async{
      sharedPreferences=await SharedPreferences.getInstance();
      sharedPreferences!.remove("a_year");
      sharedPreferences!.remove("a_sem");
 }
 String? sem;
 String? yer;
 bool? truth;
  Future getAllDaysColor() async{
      sharedPreferences=await SharedPreferences.getInstance();
      yer=sharedPreferences!.getString("a_year");
      sem=sharedPreferences!.getString("a_sem");
      truth=sharedPreferences!.getBool("truth");
 }
 @override
  void initState() {
    getAllDaysColor();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
 getAllDaysColor();
    setState(() {
      if(sem==null || yer==null){
          setAllDaysColor(widget.year.toString(),'ONE'); 
      }
         
    });
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
              DropdownButton<String>(
                iconSize: MediaQuery.of(context).size.width * 0.045,
                isExpanded: false,
                isDense: false,
                value: dropdownvalue,
                onChanged: (symbol) {
                  setState(() {
                    dropdownvalue=symbol!;
                    if(yer!=null){
                      print("waiting for remove "+yer!+" "+sem!);
                      
                        print(yer!+" "+sem!+" removed");
                        //apa
                        if(truth==false){
                           removeAllDaysColor();
                          setAllDaysColor(widget.year.toString(),dropdownvalue);
                        }
                         print(widget.year.toString()+" "+
                        dropdownvalue+" replace them");
                    }
                    else{
                    print("mbona year ni null");
                    }
                   
                  });
                   
                },
                items: lang.map((String e) {
                        return DropdownMenuItem<String>(
                          onTap: () {
                            
                          },
                      child: Text(
                        e,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                      value: e,
                    ); 
                }).toList(),     
                  
              ),
            ],
          ),
        ),
        const Divider(),
        dropdownvalue=="ONE" && (widget.year==1)?
        Expanded(flex:1,child:OverallAttendance(
          semister: 'ONE', year: 1, college: widget.college, programme: widget.programme)):
        (widget.year==1)? Expanded(
        flex: 1,
        child: Center(child:Text("First Year Semister 2 Not Yet Released"))
        ) :
        dropdownvalue=="ONE" && widget.year==2 ?
        Expanded(flex:1,child:OverallAttendance(semister: 'ONE', year: 2, college: widget.college, 
        programme: widget.programme)):
        widget.year==2 ?
       Expanded(
        flex: 1,
        child: Center(child:Text("Second Year Semister 2 Not Yet Released"))
        ) :
        dropdownvalue=="ONE" && widget.year==3?
        Expanded(flex:1,child:OverallAttendance(semister: 'ONE', year: 3, college: widget.college,
         programme: widget.programme)):
        widget.year==3?
       Expanded(
        flex: 1,
        child: Center(child:Text("Third Year Semister 2 Not Yet Released"))
        ) :
        dropdownvalue=="ONE" && widget.year==4?
        Expanded(flex:1,child:OverallAttendance(semister: 'ONE', year: 4, college: widget.college, 
        programme: widget.programme,)):
        widget.year==4?
       Expanded(
        flex: 1,
        child: Center(child:Text("Forth Year Semister 2 Not Yet Released"))
        ) :Expanded(child: Center(child: Text("No Data Available"),))
         
             
        
      
      ],
    );
  }
}