import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udom_timetable/layouts/Screens/Home.dart';
import 'package:udom_timetable/layouts/Screens/college.dart';
import 'package:udom_timetable/layouts/Screens/notification.dart';
import 'package:udom_timetable/layouts/Screens/sync.dart';
import 'package:udom_timetable/layouts/Screens/venue.dart';

class Dashboard extends StatefulWidget {
  
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin{
  late int currentindex=0;
  late AnimationController controler;
  late Animation lefcurvve,animation,delayed,lateDelayed,muchdelayed;
 late Widget content;

    final List<Widget> _children = const [
            Home(),
            College(),
            Venue(),
             Synchronize(),
             Notifications(),
             ];
  @override
  void initState() {
    content=_children[currentindex];
    controler=AnimationController(vsync: this,duration:Duration(seconds: 3));
    animation=Tween(begin: -1.0,end: 0.0).animate(
      CurvedAnimation(parent: controler, 
    curve: Curves.fastOutSlowIn,
    ));
    delayed = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: controler,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));
       muchdelayed = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: controler,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));
         lefcurvve = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: controler,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut))); 
    
    super.initState();
  }

@override
  void dispose() {
    controler.dispose();
    super.dispose();
  }

void onTabTapped(int index){
    setState(() {
      currentindex=index; 
      content=_children[currentindex];   
    });
}


  @override
  Widget build(BuildContext context) {
    Color bottom=Colors.white;
     final ThemeData mode = Theme.of(context);
var whichMode=mode.brightness;
if(whichMode==Brightness.dark){
  setState(() {
       bottom=Colors.black12;
      });
  }
    return
    AnimatedBuilder(
      animation: controler,
      builder: (context,child) {
        final GlobalKey<ScaffoldState> _scaffoldKey =
            new GlobalKey<ScaffoldState>();
    
     return Scaffold(
      key:_scaffoldKey,
      
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bottom,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: currentindex,
        unselectedFontSize: 14,
        elevation: 2.0,
        enableFeedback: true,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_outlined),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.house),
              activeIcon: Icon(Icons.house),
              label: "College"),
          BottomNavigationBarItem(
              icon: Icon(Icons.door_back_door_outlined),
              activeIcon: Icon(Icons.door_back_door_outlined),
              label: "Venue"),
       
          BottomNavigationBarItem(
              icon: Icon(Icons.post_add_rounded),
              activeIcon: Icon(Icons.post_add_rounded),
              label: "Posts"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              activeIcon: Icon(Icons.notifications),
              label: "Notify"),
        ],
      ),
    );
    }
    );
  }
}