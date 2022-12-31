import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';

class Synchronize extends StatefulWidget {
  const Synchronize({super.key});

  @override
  State<Synchronize> createState() => _SynchronizeState();
}

class _SynchronizeState extends State<Synchronize> {
  SharedPreferences? sharedPreferences;
   String? favourate;
  Future getPreferences() async{
    sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      favourate=sharedPreferences!.getString("college")!;
    });
  }
  @override
  void initState() {
   getPreferences();
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
    return Scaffold(
       appBar: AppBar(

        title:new Text("Synchronize"),
        
        backgroundColor: appbar,
        actions: [
  
        ],
        
      ),
      body: Container(child:favourate==null?Center(child: Text("No Favourate Availbale Please Select"),): 
    Center(child: Text("This is Synchronization for ${sharedPreferences!.getString("college")}"),),),
  
    );
  }
}


