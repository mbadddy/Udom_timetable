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
import 'package:udom_timetable/services/Translation/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
Future setLanguage(String lang)async{
  sharedPreferences=await SharedPreferences.getInstance();
  sharedPreferences!.setString("language", lang);
}
String? language;
Future getLanguage()async{
  sharedPreferences=await SharedPreferences.getInstance();
  setState(() {
    language=sharedPreferences!.getString("language");
  });
  
}
   bool check=false;
   final String title = 'language';
   String dropdownvalue = 'English';
  // final LanguageController _languageController = Get.find();
final List<String> lang=["English","Swahili","Arabic","Hindi","German","French"];
  
@override
  void initState() {
   getPreference();
   getLanguage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(language!=null){
      setState(() {
        dropdownvalue=language!;
      });
      print("language is ${language}............");
    }
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
        title:Text(AppLocalizations.of(context)!.setting,),
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
                  activeTrackColor: mainColor.withOpacity(0.4),
                  activeColor: mainColor,
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
                     print(dropdownvalue);
                     final provider=Provider.of<LocaleProvider>(context,listen: false);
                     if(dropdownvalue=="English"){
                        provider.setLocale(const Locale("en"));
                        
                     }
                      if(dropdownvalue=="Swahili"){
                        provider.setLocale(const Locale("sw"));
                     }
                      if(dropdownvalue=="Arabic"){
                        provider.setLocale(const Locale("ar"));
                     }
                      if(dropdownvalue=="Hindi"){
                        provider.setLocale(const Locale("hi"));
                     }
                      if(dropdownvalue=="German"){
                        provider.setLocale(const Locale("de"));
                     }
                       if(dropdownvalue=="French"){
                        provider.setLocale(const Locale("fr"));
                     }
                    setLanguage(dropdownvalue);
                    getLanguage();
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
           const Divider(),

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