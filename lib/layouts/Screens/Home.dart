import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/combine/allcombines.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/Screens/Colors/themes.dart';
import 'package:udom_timetable/layouts/Screens/Setting.dart';
import 'package:udom_timetable/layouts/Screens/Topslider/image.dart';
import 'package:udom_timetable/layouts/Screens/components/addtion.dart';
import 'package:udom_timetable/layouts/Screens/components/main_menu.dart';
import 'package:udom_timetable/layouts/Screens/components/wallet.dart';
import 'package:udom_timetable/layouts/Screens/components/xpbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController? _pageController;
   Timer? _pageAnimationTimer;
  int _page = 0;

void _animatePages() {
    if (_pageController == null) return;
 
    if (_page < 2) {
      _pageController?.nextPage(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeIn,
      );
    }
  }
 
 @override
  void initState() {
    _pageController = PageController();
    _pageAnimationTimer =Timer.periodic(const Duration(seconds:5), (timer) {_animatePages(); });
    super.initState();
  }
@override
  void dispose() {
    _pageAnimationTimer?.cancel();
    _pageAnimationTimer = null;
    _pageController?.dispose();
    super.dispose();
  }

  void popupAction(String option) {
    if(option=='Setting'){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Setting()));
    }
    if(option=='Combines'){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllCombine()));   
    }
         print(option);
  }

  final List<Widget> slider=[
                 ContentSlider(image: 'assets/images/udom1.jpg',
                 title: 'Prof. Lughano J. Kusiluka', 
                 subtitle: 'Vice Chancellor'),
                 ContentSlider(image: 'assets/images/udom3.jpg',
                 title: '13th Graduation Ceremony', 
                 subtitle: 'University of Dodoma'),
                 ContentSlider(image: 'assets/images/udom2.jpg',
                 title: 'Best Students', 
                 subtitle: 'At 13th Graduation Ceremony 2022'),
  ];
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
     List<String> options = ['Setting', 'Combines'];
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:new Text("Home"),
        
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
   
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
             Expanded(
              flex: 1,
              child: 
             PageView.builder(
              itemBuilder: (context, index) {
                return Container(
                  alignment:Alignment.center,
                  width: 50,
                  height: 50,
                  child: slider[index % slider.length],
                  );

              },
             controller: _pageController,
             reverse: false,
           
             )
             ),
             Expanded(
              flex: 2,
              child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: const [
                  SizedBox(
                    height: 15,
                  ),
                  Wallet(),
                  SizedBox(
                    height: 20,
                  ),
                  MainMenu(),
                  SizedBox(
                    height: 20,
                  ),
                  XpBar(),
                  SizedBox(
                    height: 15,
                  ),
                  // Wallet(),
                ]),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Addition(),
              ),
              const SizedBox(
                height: 20,
              ),
           
            ],
          ),
        ],
      ),
      )
         



      ]),
      
    );
  }
}