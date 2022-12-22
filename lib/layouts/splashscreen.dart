import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return 
    Scaffold(
      body:
    Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.27,
            width: MediaQuery.of(context).size.width * 0.35,
            child: FlareActor(
              "assets/school spleash.flr",
              animation: "start",
              fit: BoxFit.fill,
            ),
          ),
        ),
    )
    );
  }
}