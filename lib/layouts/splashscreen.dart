import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/dashboard.dart';

class SPlashscreen extends StatefulWidget {
  const SPlashscreen({super.key});

  @override
  State<SPlashscreen> createState() => _SPlashscreenState();
}

class _SPlashscreenState extends State<SPlashscreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 7),start);
    super.initState();
  }

  start() {
    setState(() {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Dashboard(),),
          (route)=>false ,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Color appbar=Colors.transparent;
  
 final ThemeData mode = Theme.of(context);
var whichMode=mode.brightness;
if(whichMode==Brightness.dark){
  setState(() {
          appbar=Colors.black12;
      });
}
    return 
    Scaffold(
      body:
    Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Container(
             decoration: BoxDecoration(
                          color: appbar,
                          borderRadius: BorderRadius.circular(60)),
            height: MediaQuery.of(context).size.height * 0.17,
            width: MediaQuery.of(context).size.width * 0.35,
            child: Image.asset(
              "assets/images/logo_prev_ui.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
    )
    );
  }
}