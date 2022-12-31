import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:udom_timetable/services/Modal/timetable.dart';

class TimetableService{
 Future<Timetable> fetchTimetable() async{
  print("inafikaaaaa");
  var resp=await http.get(Uri.parse("http://192.168.137.1:8000/all_timetable/?format=json"));
   print("imepita");
  if(resp.statusCode==200)
  {
    
    return Timetable.fromJson(jsonDecode(resp.body));
  }
  else{
    throw Exception('Failed to load timetable');
    
  }
 }


}
