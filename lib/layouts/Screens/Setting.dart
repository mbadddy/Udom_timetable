import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/simple_builder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/Screens/Colors/themes.dart';
import 'package:udom_timetable/layouts/Screens/Language/language.dart';
import 'package:udom_timetable/layouts/Screens/SharedPreference/preference.dart';
import 'package:udom_timetable/layouts/Screens/components/customdivider.dart';


class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}


class _SettingState extends State<Setting> {
 SharedPreferences? sharedPreferences;

Future getPreference() async{
  sharedPreferences=await SharedPreferences.getInstance();
  
}

   bool check=false;
   final String title = 'language';
  // final LanguageController _languageController = Get.find();
  //auto switch
  //
bool? isSwitchedd;
  bool isSwitched = false;  
  Future setSwitchOn(bool isSwitchedd)async{
    sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences!.setBool("autoSwiched", isSwitchedd);
  }
    Future setSyncSwitchOn(isSwitchedd)async{
    sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences!.setBool("syncSwiched", isSwitchedd);
  }
   Future getSwitchOn()async{
    sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      isSwitchedd=sharedPreferences!.getBool("autoSwiched");
      sharedPreferences!.getBool("syncSwiched");
    });
  }
  void toggleSwitch(bool value) {  
  
    if(isSwitched == false)  
    {  
      setState(() {  
        isSwitched = true; 
        setSwitchOn(isSwitched);
        setSyncSwitchOn(isSwitched);
        getSwitchOn(); 
      });  
    }  
    else  
    {  
      setState(() {  
        isSwitched = false;  
        setSwitchOn(isSwitched);
        setSyncSwitchOn(isSwitched);
        getSwitchOn();
      });  
    } 
  } 
  //

  //
  bool? issSwitchedd;
  bool issSwitched = false;  

  Future setSwitchOnn(bool isSwitchedd)async{
    sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences!.setBool("syncSwiched", isSwitchedd);
  }
   Future getSwitchOnn()async{
    sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      issSwitchedd=sharedPreferences!.getBool("syncSwiched");
    });
  }
  void toggleSwitchh(bool value) {  
  
    if(issSwitched == false)  
    {  
      setState(() {  
        issSwitched = true; 
        setSwitchOnn(issSwitched);
        getSwitchOnn(); 
      });  
    }  
    else  
    {  
      setState(() {  
        issSwitched = false;  
        setSwitchOnn(issSwitched);
        getSwitchOnn();
      });  
    } 
  }  
  //
@override
  void initState() {
    getSwitchOn();
    getSwitchOnn();
    getPreference();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
       setState(() {
       if(isSwitchedd!=null && isSwitchedd==true){
        setSwitchOnn(true);
       }
     });
   
     Color appbar=appColr;
  
 final ThemeData mode = Theme.of(context);
var whichMode=mode.brightness;
if(whichMode==Brightness.dark){
  setState(() {
          appbar=Colors.black12;
      });
}
    Size screen=MediaQuery.of(context).size;
    return 
    
     Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      
          return Scaffold(
      appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: () {
          Navigator.of(context).pop();
        },),
        centerTitle: true,
        title:Text("Setting"),
        backgroundColor: appbar,
        ),
      
        body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 9,
              child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dark Mode',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
              Switch(
                  value: themeNotifier.isDark,
                  onChanged: (value) { 
                    themeNotifier.isDark?
                    themeNotifier.isDark=false:
                    themeNotifier.isDark=true;
                
                  },
                   activeColor: Colors.blue,  
              activeTrackColor: Colors.yellow,  
              inactiveThumbColor: Colors.redAccent,  
              inactiveTrackColor: Colors.orange,  
                ),
              
            ],
          ),
        ),
        const Divider(),
        Column(
      children: [

                Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Automatic Sync',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
             Switch(
                  onChanged: toggleSwitch,
                value: isSwitchedd ?? isSwitched,  
              activeColor: Colors.blue,  
              activeTrackColor: Colors.yellow,  
              inactiveThumbColor: Colors.redAccent,  
              inactiveTrackColor: Colors.orange,  
                
              ),
            ],
          )),
           const Divider(),
            Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Normal Sync',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
             Switch(
              onChanged: isSwitchedd==true ? null: toggleSwitchh,
              value: isSwitchedd==true ? true: issSwitchedd ?? issSwitched,  
              activeColor: Colors.blue,  
              activeTrackColor: Colors.yellow,  
              inactiveThumbColor: Colors.redAccent,  
              inactiveTrackColor: Colors.orange,  
                
              ),
            ],
          )),
         const Divider()
      ],
    )
      ],
    ),
    )
        ])
    );
        });
    
    
  }
}