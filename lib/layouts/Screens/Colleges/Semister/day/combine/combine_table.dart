import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/combine/allcombines.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/combine/combine_days.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/combine/description_card.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';

class Combine extends StatefulWidget {
  const Combine({super.key});

  @override
  State<Combine> createState() => _CombineState();
}

class _CombineState extends State<Combine> {
   SharedPreferences? sharedPreferences;

   
//weekly
 String? college;
 String? programe;
 String? year;
 String? semist;
  Future getWeekly() async{
       sharedPreferences=await SharedPreferences.getInstance();
      setState(() {
         college=sharedPreferences!.getString("a_coll"); 
          programe=sharedPreferences!.getString("a_prog"); 
          year=sharedPreferences!.getString("a_year"); 
          semist=sharedPreferences!.getString("a_sem"); 
      });
 }
 //by day
 List<String>? coll;
  List<String>? prog;
  List<String>? yea;
  List<String>? sem;
  List<String>? day;

  Future getByDay() async{
       sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
         coll=sharedPreferences!.getStringList("colleges"); 
          prog=sharedPreferences!.getStringList("programes");
           yea=sharedPreferences!.getStringList("years");
            sem=sharedPreferences!.getStringList("semisters");
             day=sharedPreferences!.getStringList("days"); 
    });
 }

 @override
  void initState() {
    getByDay();
    getWeekly();
    super.initState();
  }
  void viewCombines(String option) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllCombine()));
        
  }
   List<String> options = ['View',"Change"];
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
    return Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title:new Text("Combine"),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: () {
          Navigator.of(context).pop();
        },),
        backgroundColor: appbar,
        actions: [
       PopupMenuButton(
          position: PopupMenuPosition.under,
          onSelected:viewCombines,
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
        children: <Widget>[
            Expanded(
              flex: 9,
              child: Column(
              children: [
                (college!=null && coll!=null) && college!.isNotEmpty && coll!.isNotEmpty? Description(college: college!, programme: programe!, sem: semist!, year: int.parse(year!)):
                college!=null && college!.isNotEmpty? Description(college: college!, programme: programe!, sem: semist!, year: int.parse(year!)):
                coll!=null && coll!.isNotEmpty?Description(college: coll![0], programme: prog![0], sem: sem![0], year:int.parse(yea![0])):
                Center(child:Text("No favourate Available")),
                Expanded(child: 
                (college!=null && coll!=null) && (college!.isNotEmpty && coll!.isNotEmpty)? CombinedDays(semister: semist!, year: int.parse(year!), college: college!, programme: programe!):
                college!=null && college!.isNotEmpty? CombinedDays(semister: semist!, year: int.parse(year!), college: college!, programme: programe!):
                coll!=null && coll!.isNotEmpty? CombinedDays(semister: sem![0], year: int.parse(yea![0]), college:  coll![0], programme: prog![0]):
                Center(child:Text("No favourate Available")),
                )
                
                 ]
            )
            )

        ],
      ),
    );
  }
} 