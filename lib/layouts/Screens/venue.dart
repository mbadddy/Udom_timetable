import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';

class Venue extends StatefulWidget {
  const Venue({super.key});

  @override
  State<Venue> createState() => _VenueState();
}

class _VenueState extends State<Venue> {
  SharedPreferences? sharedPreferences;
   String? favourate;
  

  Future getPreferences() async{
    sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      favourate=sharedPreferences!.getString("college")!;

    });
  }

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
  bool? combine;
  Future getByDay() async{
       sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
         coll=sharedPreferences!.getStringList("colleges"); 
          prog=sharedPreferences!.getStringList("programes");
           yea=sharedPreferences!.getStringList("years");
            sem=sharedPreferences!.getStringList("semisters");
             day=sharedPreferences!.getStringList("days"); 
             combine=sharedPreferences!.getBool("favourate"); 
    });
 }
 
  @override
  void initState() {
    getPreferences();
    getByDay();
    getWeekly();
    super.initState();
  }
  
  void popupAction(String option) {

         print(option);
  }
   List<String> options = ['Change Favourate', 'Delete Favourate'];
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

        title:new Text("Venue"),
        
        backgroundColor: appbar,
        actions: [
        PopupMenuButton(
          position: PopupMenuPosition.under,
          onSelected:popupAction,
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
  
      body:Padding(
        padding: EdgeInsets.only(top:40),
        child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Center(child: Text("This is by Day"),),
          Expanded(child:    
         
        coll==null? Center(child: Text("By day Not Found"),):
        ListView.builder(
        itemCount: coll!.length,
        itemBuilder: (context, index) {
          String col=coll![index];
          String prg=prog![index];
          String yr=yea![index];
          String sm=sem![index];
          String dy=day![index];
          return ListTile(
          title: Text("College: "+col+" Programme "+prg),
          subtitle: Text("Year "+yr+" semister "+sm+" day "+dy),
          leading:Icon(Icons.school_sharp)
          );
              },
        ),
       
          ),
        Text("This is by Weekly"),
          Expanded(child:    
         college==null?Center(child: Text("Weekly Not Found"),):
        Text("College: "+college!+" programme: "
          +programe!+" year: "+year!+" Semister: "+semist!+"combine: ${combine}"),
          )
        ],
      )
      ,)
      
      
      
    );
  
  }
}