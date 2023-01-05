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

//
bool? isSwitchedd;
  bool isSwitched = false;  
   bool? autoSwitched;
  Future setSwitchOn(bool isSwitchedd)async{
    sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences!.setBool("syncSwiched", isSwitchedd);
  }
   Future getSwitchOn()async{
    sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      isSwitchedd=sharedPreferences!.getBool("syncSwiched");
      autoSwitched=sharedPreferences!.getBool("autoSwiched");  
    });
  }
  void toggleSwitch(bool value) {  
  
    if(isSwitched == false)  
    {  
      setState(() {  
        isSwitched = true; 
        setSwitchOn(isSwitched);
        getSwitchOn(); 
      });  
    }  
    else  
    {  
      setState(() {  
        isSwitched = false;  
        setSwitchOn(isSwitched);
        getSwitchOn();
      });  
    } 
  }  

//


  @override
  void initState() {
   getSwitchOn();
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
     setState(() {
       if(autoSwitched!=null && autoSwitched==true){
        setSwitchOn(true);
       }
     });
    return Scaffold(
       appBar: AppBar(

        title:new Text("Synchronize"),
        
        backgroundColor: appbar,
        actions: [
  
        ],
        
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                  Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Synchronize',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
             Switch(
                  onChanged: autoSwitched!=null && autoSwitched==true ? null: toggleSwitch,
                value: autoSwitched!=null && autoSwitched==true ? true: isSwitchedd ?? isSwitched,  
              activeColor: Colors.blue,  
              activeTrackColor: Colors.yellow,  
              inactiveThumbColor: Colors.redAccent,  
              inactiveTrackColor: Colors.orange,  
                
              ),
            ],
          ),
        ),
        const Divider(),
        ],
      )
  
    );
  }
}


