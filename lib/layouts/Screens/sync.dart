import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/screens/home_screen.dart';

class Synchronize extends StatefulWidget {
  const Synchronize({super.key});

  @override
  State<Synchronize> createState() => _SynchronizeState();
}

class _SynchronizeState extends State<Synchronize> {





  @override
  void initState() {
    super.initState();
  }
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
   ;
    return HomeScreen();
  }
}


