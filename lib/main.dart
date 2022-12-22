import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/Screens/Colors/themes.dart';
import 'package:udom_timetable/layouts/splashscreen.dart';


void main() async{
  //storage
  WidgetsFlutterBinding.ensureInitialized();
  Directory document=await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox<String> ("users");
  await Hive.openBox<String> ("combine");
  //end
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
    ChangeNotifierProvider(create:  (_) => ModelTheme()
    ,
    child: Consumer<ModelTheme>(
      builder: (context, ModelTheme value, child) =>
          ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
          return GetMaterialApp(
            darkTheme: ThemeData.dark(),
            
            themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: 'UDOM Timetable',
      theme:  value.isDark?
      ThemeData(
        brightness: Brightness.dark
      )
      :
      ThemeData(
         brightness: Brightness.light,
                  primaryColor: Colors.green,
                  primarySwatch: Colors.green
      )
      ,
      home: SPlashscreen(),
    );
      },
    
    )),
    );
    
  

  }
}
