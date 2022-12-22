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
   String dropdownvalue = 'English';
  // final LanguageController _languageController = Get.find();
final List<String> lang=["English","Swajili","Spanish","Japanese"];
  
@override
  void initState() {
   getPreference();
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
              ValueBuilder<bool?>(
                initialValue: themeNotifier.isDark,
                builder: (isChecked, updateFn) => Switch(
                  value: isChecked!,
                  onChanged: (value) { 
                    themeNotifier.isDark?
                    themeNotifier.isDark=false:
                    themeNotifier.isDark=true;
                
                  },
                  activeTrackColor: mainColor.withOpacity(0.4),
                  activeColor: mainColor,
                ),
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
                title,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
              DropdownButton<String>(
                iconSize: MediaQuery.of(context).size.width * 0.045,
                isExpanded: false,
                isDense: false,
                value: dropdownvalue,
                onChanged: (symbol) {
                   setState(() {
                     dropdownvalue=symbol!;
                   });
                },
                items: lang.map((String e) {
                        return DropdownMenuItem<String>(
                          onTap: () {
                            
                          },
                      child: Text(
                        e,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                      value: e,
                    ); 
                }).toList(),     
                  
              ),
            ],
          ),
        ),
        const Divider(),

                Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notification',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
              ValueBuilder<bool?>(
                initialValue: false,
                builder: (isChecked, updateFn) => Switch(
                  value: isChecked!,
                  onChanged: (value) { 
                    
                
                  },
                  activeTrackColor: mainColor.withOpacity(0.4),
                  activeColor: mainColor,
                ),
              ),
            ],
          ),
        ),
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