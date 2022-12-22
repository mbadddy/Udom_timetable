// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
   SharedPreferences? preference;
  Preference({
    this.preference,
  });
  Future getPreference() async{
  preference=await SharedPreferences.getInstance();
 
}
   
}
