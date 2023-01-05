import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udom_timetable/services/Modal/timetable.dart';

class TimetableService{
 Future<Timetable> fetchTimetable() async{

  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  var response;
  if(sharedPreferences.getBool("autoSwiched")!=null && sharedPreferences.getBool("autoSwiched")==true){
    print("auto true...............................................................");
    response=await http.get(Uri.parse("http://192.168.137.1:8000/all_timetable/?format=json"));
  }
  else if(sharedPreferences.getBool("syncSwiched")==true){
     print("Manual true...............................................................");
    response=await http.get(Uri.parse("http://192.168.137.1:8000/all_timetable/?format=json"));
  }
  else{
      print("NEither Auto Nor Manual is true...............................................................");
    throw Exception('Auto Sync Failed');

  }
 
   print("imepita");
  if(response.statusCode==200)
  {
    
    return Timetable.fromJson(jsonDecode(response.body));
  }
  else{
    throw Exception('Failed to load timetable');
    
  }
 }


}
