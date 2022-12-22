import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';

ThemeData kAppTheme = ThemeData(
  primaryColor: kPrimaryColor,
  highlightColor: kHighlightColor,
  backgroundColor: kPrimaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0
  ),
  fontFamily: 'PlayFair',
  
  textTheme: TextTheme(     
     headline1: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 34,),
     headline2: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26,),
     headline3: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 20 ), 
     headline4: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13, fontFamily: 'Roboto'),
     headline5: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16, ),
     headline6: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14, ),
     subtitle1: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13, ),
     bodyText1: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 15, fontFamily: 'Roboto',height: 1.4),
     caption: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Roboto'),
  )
  
);







class MyThemePreferences {
  static const THEME_KEY = "theme_key";

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(THEME_KEY, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(THEME_KEY) ?? false;
  }
}


class ModelTheme extends ChangeNotifier {
  late bool _isDark;
  late MyThemePreferences _preferences;
  bool get isDark => _isDark;

  ModelTheme() {
    _isDark = false;
    _preferences = MyThemePreferences();
    getPreferences();
  }
//Switching the themes
  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}