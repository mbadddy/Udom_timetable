import 'dart:async';
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:shared_preferences_ios/shared_preferences_ios.dart';
import 'package:udom_timetable/layouts/Screens/Colors/themes.dart';
import 'package:udom_timetable/layouts/Screens/notification/notification.dart';
import 'package:udom_timetable/layouts/Screens/notification/promodoroTimer.dart';
import 'package:udom_timetable/layouts/splashscreen.dart';

import 'firebase_options.dart';

bool? combinee;
int? notifyy;
void main() async {
  //storage
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox<String>("users");
  await Hive.openBox<List<String>>("combine");
  await Hive.openBox<List<String>>("Exams");
  await Hive.openBox<Uint8List>("blogimages");
  await Hive.openBox<List<String>>("timetable");
  await Hive.openBox<List<String>>("del_docs");
  await Hive.openBox<String>("swahili");
  await Hive.openBox<String>("arabic");
  await Hive.openBox<String>("france");

  await NotificationService().setup();
  MobileAds.instance.initialize();
  //

  //end
  runApp(MyApp());
  Box<List<String>> all_timetable = Hive.box<List<String>>("timetable");
  //combine
  Box<List<String>> combinebox = Hive.box<List<String>>("combine");
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  List<String>? c_colleges;
  List<String>? c_progs;
  List<String>? c_yrs;
  List<String>? c_sems;
  List<String>? c_cozes;
  List<String>? c_venyus;
  List<String>? c_dayss;
  List<String>? c_time_froms;
  List<String>? c_tymes;
  List<String>? c_instructs;
  c_colleges = combinebox.get("colleges");
  c_progs = combinebox.get("programmes");
  c_yrs = combinebox.get("years");
  c_sems = combinebox.get("semisters");
  c_venyus = combinebox.get("venues");
  c_dayss = combinebox.get("days");
  c_time_froms = combinebox.get("time_from");
  c_tymes = combinebox.get("time_to");
  c_cozes = combinebox.get("courses");
  c_instructs = combinebox.get("instructors");

  bool? combine = sharedPreferences.getBool("favourate");

  //combine
  //day
  List<String>? coll;
  List<String>? prog;
  List<String>? yea;
  List<String>? sem;
  List<String>? day;
  coll = sharedPreferences.getStringList("colleges");
  prog = sharedPreferences.getStringList("programes");
  yea = sharedPreferences.getStringList("years");
  sem = sharedPreferences.getStringList("semisters");
  day = sharedPreferences.getStringList("days");

  List<String>? venyuuuuuus = all_timetable.get("venues");
  List<String>? lectureees = all_timetable.get("lectures");
  List<String>? tymesss = all_timetable.get("times");
  List<String>? dayyys = all_timetable.get("days");
  List<String>? categoryyyys = all_timetable.get("categories");
  List<String>? coursesss = all_timetable.get("courses");
  List<String>? proggggs = all_timetable.get("programmes");
  List<String>? yerrrs = all_timetable.get("years");
  List<String>? semmms = all_timetable.get("semisters");

  //end

//exam
  Box<List<String>> exambox = Hive.box<List<String>>("Exams");
  bool? myfavourate = sharedPreferences.getBool("e_favourate");
  List<String>? e_colleges = exambox.get("e_colleges");
  List<String>? e_progs = combinebox.get("e_programmes");
  List<String>? e_yrs = combinebox.get("e_years");
  List<String>? e_sems = combinebox.get("e_semisters");
  List<String>? e_venyus = combinebox.get("e_venues");
  List<String>? e_dayss = combinebox.get("e_days");
  List<String>? e_time_froms = combinebox.get("e_time_from");
  List<String>? e_tymes = combinebox.get("e_time_to");
  List<String>? e_cozes = combinebox.get("e_courses");

//end exam
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
    getHomeNotification();
    AndroidAlarmManager.periodic(
        const Duration(seconds: 60), 1, callbackDispatcher,
        params: {
          "combine": combine,
          "notify": sharedPreferences.getInt("notify"),
          "c_programes": c_progs,
          "c_colleges": c_colleges,
          "c_years": c_yrs,
          "c_semister": c_sems,
          "c_venues": c_venyus,
          "c_days": c_dayss,
          "c_t_from": c_time_froms,
          "c_t_to": c_tymes,
          "c_cozes": c_cozes,
          "c_instructs": c_instructs
        },
        rescheduleOnReboot: true,
        wakeup: true,
        exact: true);

    AndroidAlarmManager.periodic(
        const Duration(seconds: 60), 2, callBackDyDispacher,
        params: {
          "d_programes": prog,
          "d_colleges": coll,
          "d_years": yea,
          "d_semister": sem,
          "d_day": day,
          "dt_venues": venyuuuuuus,
          "dt_days": dayyys,
          "dt_instruct": lectureees,
          "dt_tyme": tymesss,
          "dt_cozes": coursesss,
          "dt_catgry": categoryyyys,
          "dt_progs": proggggs,
          "dt_yr": yerrrs,
          "dt_sem": semmms,
          "notify": sharedPreferences.getInt("notify")
        },
        rescheduleOnReboot: true,
        wakeup: true,
        exact: true);

    AndroidAlarmManager.periodic(const Duration(seconds: 60), 3, callBackExam,
        params: {
          "exam": myfavourate,
          "notify": sharedPreferences.getInt("notify"),
          "e_programes": e_progs,
          "e_colleges": e_colleges,
          "e_years": e_yrs,
          "e_semister": e_sems,
          "e_venues": e_venyus,
          "e_days": e_dayss,
          "e_t_from": e_time_froms,
          "e_t_to": e_tymes,
          "e_cozes": e_cozes,
        },
        rescheduleOnReboot: true,
        wakeup: true,
        exact: true);

    if (sharedPreferences.getInt("notify") == null) {
      AndroidAlarmManager.cancel(1);
    }
  }
}

@pragma('vm:entry-point')
Future<void> callBackExam(int id, Map<String, dynamic> data) async {
  print(
      "ipo kwenye exam...........................${data["notify"]}...${data['exam']}");
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    SharedPreferencesAndroid.registerWith();
  }
  if (Platform.isIOS) {
    SharedPreferencesIOS.registerWith();
  }
  DateTime day = DateTime.now();
  String today = DateFormat.EEEE().format(day);
  String td_time = DateFormat.Hm().format(day);
  if (data["notify"] != null) {
    if (data['exam'] == true) {
      if (data["e_days"] != null) {
        for (var c_day = 0; c_day < data["e_days"]!.length; c_day++) {
          if (data["e_days"]![c_day] == today) {
            var noww = DateTime.now();
            var splitted_now = noww.toString().split(" ");
            var splitted_now2 = noww.toString().split(" ");
            var dttt1;
            var dttt2;
            var dttttt1;
            var dttttt2;
            var category;
            var c_time = data['e_t_from']![c_day];
            c_time = "${c_time}:00";
            td_time = "${td_time}";

            splitted_now2[1] = c_time;
            dttt1 = splitted_now2;
            splitted_now[1] = td_time;
            dttt2 = splitted_now;
            dttttt1 = dttt1[0] + " " + dttt1[1];
            dttttt2 = dttt2[0] + " " + dttt2[1];
            DateTime dt1 = DateTime.parse(dttttt1);
            DateTime dt2 = DateTime.parse(dttttt2);
            Duration durr = dt1.difference(dt2);
            var time_category;
            var dataa = data['e_t_from']![c_day].split(":");
            print(
                "exam apa juuu.............................. ${durr.inMinutes}");
            if (int.parse(dataa[0]) >= 0 && int.parse(dataa[0]) < 12) {
              time_category = "AM";
            } else {
              time_category = "PM";
            }
            if (durr.inMinutes == data["notify"] ||
                durr.inMinutes == data['notify'] - 1) {
              setHomeNotification(
                  data["e_cozes"]![c_day],
                  '${data['e_t_from']![c_day]}-${data['e_t_to']![c_day]}',
                  '${data['e_days'][c_day]}',
                  '${data['e_venues'][c_day]}',
                  '');
              getHomeNotification();
              PromodoroTimer().enterAtWork(
                  "After ${data["notify"]} minutes You Have exam to Attend",
                  "${data["e_cozes"]![c_day]}  ${data['e_t_from']![c_day]} $time_category  ${data["e_venues"]![c_day]}",
                  "before timetable",
                  "pristive",
                  "new Payload");
            }
            if (durr.inMinutes == 0) {
              PromodoroTimer().enterAtWork(
                  "Your Exam time is ready! now",
                  "${data["e_cozes"]![c_day]}  ${data['e_t_from']![c_day]} $time_category  ${data["e_venues"]![c_day]}",
                  "exact imetable",
                  "pristive",
                  "new Payload");
            }
          }
        }
      }
    }
  }
}

@pragma('vm:entry-point')
Future<void> callBackDyDispacher(int id, Map<String, dynamic> data) async {
  print("imefika apaa mwanzo ${data['notify']}");
  WidgetsFlutterBinding.ensureInitialized();
  if (data["notify"] == null) {
    data["notify"] == 30;
  }
  if (data['notify'] != null) {
    DateTime day = DateTime.now();
    String today = DateFormat.EEEE().format(day);
    if (data['d_programes'] != null &&
        data['d_programes'].isNotEmpty &&
        data['dt_venues'] != null &&
        data['dt_days'].isNotEmpty) {
      if (data['d_day'].length > 1) {
        print("more than once............................");
        for (var p = 0; p < data['d_day'].length; p++) {
          if (data['d_day'][p] == today) {
            String td_time = DateFormat.Hm().format(day);
            for (var dy = 0; dy < data['dt_venues'].length; dy++) {
              if (data['dt_progs'][dy] == data['d_programes'][p] &&
                  data['dt_yr'][dy] == data['d_years'][p] &&
                  data['dt_sem'][dy] == data['d_semister'][p] &&
                  data['dt_days'][dy] == data['d_day'][p]) {
                var arr = data['dt_tyme'][dy].split("-");
                var noww = DateTime.now();
                var splitted_now = noww.toString().split(" ");
                var splitted_now2 = noww.toString().split(" ");
                var dttt1;
                var dttt2;
                var dttttt1;
                var dttttt2;
                var category;
                var c_time = arr[0];
                c_time = "${c_time}:00";
                td_time = "${td_time}";

                splitted_now2[1] = c_time;
                dttt1 = splitted_now2;
                splitted_now[1] = td_time;
                dttt2 = splitted_now;
                dttttt1 =
                    dttt1[0] + " " + dttt1[1].toString().replaceAll(" ", '');
                dttttt2 = dttt2[0] + " " + dttt2[1];
                DateTime dt1 = DateTime.parse(dttttt1);
                DateTime dt2 = DateTime.parse(dttttt2);
                Duration durr = dt1.difference(dt2);
                var time_category;
                var dataa = arr[1].split(":");
                if (int.parse(dataa[0]) >= 0 && int.parse(dataa[0]) < 12) {
                  time_category = "AM";
                } else {
                  time_category = "PM";
                }
                print(
                    "wait...for more than once...............durr..${durr.inMinutes}....notify....${data['notify']}");
                if (durr.inMinutes == data["notify"] ||
                    durr.inMinutes == (data['notify'] - 1)) {
                  print("tulia..........................");
                  setHomeNotification(
                      data["dt_cozes"]![dy],
                      data['dt_tyme']![dy],
                      '${data['dt_days'][dy]}',
                      '${data['dt_venues'][dy]}',
                      '${data['dt_instruct'][dy]}');
                  getHomeNotification();
                  PromodoroTimer().enterAtWork(
                      "After ${data["notify"]} minutes You Have Session to Attend",
                      "${data["dt_cozes"]![dy]}  ${data['dt_tyme']![dy]} $time_category  ${data["dt_venues"][dy]}",
                      "before timetable",
                      "pristive",
                      "new Payload");
                }
                if (durr.inMinutes == 0) {
                  PromodoroTimer().enterAtWork(
                      "Your Session time is ready! now",
                      "${data["dt_cozes"]![dy]}  ${data['dt_tyme']![dy]} $time_category  ${data["dt_venues"]![dy]}",
                      "exact timetable",
                      "pristive",
                      "new Payload");
                }
              }
            }
          }
        }
      } else {
        print("imewekwa moja favourate");
        DateTime day = DateTime.now();
        String today = DateFormat.EEEE().format(day);
        String td_time = DateFormat.Hm().format(day);
        for (var dy = 0; dy < data['dt_venues'].length; dy++) {
          if (data['dt_progs'][dy] == data['d_programes'][0] &&
              data['dt_yr'][dy] == data['d_years'][0] &&
              data['dt_sem'][dy] == data['d_semister'][0] &&
              data['dt_days'][dy] == data['d_day'][0]) {
            var arr = data['dt_tyme'][dy].split("-");
            var noww = DateTime.now();
            var splitted_now = noww.toString().split(" ");
            var splitted_now2 = noww.toString().split(" ");
            var dttt1;
            var dttt2;
            var dttttt1;
            var dttttt2;
            var category;
            var c_time = arr[1];
            c_time = "${c_time}:00";
            td_time = "${td_time}";

            splitted_now2[1] = c_time;
            dttt1 = splitted_now2;
            splitted_now[1] = td_time;
            dttt2 = splitted_now;
            dttttt1 = dttt1[0] + "" + dttt1[1];
            dttttt2 = dttt2[0] + " " + dttt2[1];
            DateTime dt1 = DateTime.parse(dttttt1);
            DateTime dt2 = DateTime.parse(dttttt2);
            Duration durr = dt1.difference(dt2);
            var time_category;
            var dataa = arr[1].split(":");
            if (int.parse(dataa[0]) >= 0 && int.parse(dataa[0]) < 12) {
              time_category = "AM";
            } else {
              time_category = "PM";
            }
            print("wait..................");
            if (durr.inMinutes == data["notify"] ||
                (durr.inMinutes == data['notify'] - 1)) {
              print("tulia..........................");
              setHomeNotification(
                  data["dt_cozes"]![dy],
                  data['dt_tyme']![dy],
                  '${data['dt_days'][dy]}',
                  '${data['dt_venues'][dy]}',
                  '${data['dt_instruct'][dy]}');
              getHomeNotification();
              PromodoroTimer().enterAtWork(
                  "After ${data["notify"]} minutes You Have Session to Attend",
                  "${data["dt_cozes"]![dy]}  ${data['dt_tyme']![dy]} $time_category  ${data["dt_venues"][dy]}",
                  "before timetable",
                  "pristive",
                  "new Payload");
            }
            if (durr.inMinutes == 0) {
              PromodoroTimer().enterAtWork(
                  "Your Session time is ready! now",
                  "${data["dt_cozes"]![dy]}  ${data['dt_tyme']![dy]} $time_category  ${data["dt_venues"]![dy]}",
                  "exact timetable",
                  "pristive",
                  "new Payload");
            }
          }
        }
      }
    }
  }
}

Future<void> setHomeNotification(course, time, day, venue, lecture) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("h_course", course);
  preferences.setString("h_time", time);
  preferences.setString("h_day", day);
  preferences.setString("h_venue", venue);
  preferences.setString("h_lecture", lecture);
}

Future<void> getHomeNotification() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  preferences.getString("h_course");
  preferences.getString("h_time");
  preferences.getString("h_day");
  preferences.getString("h_venue");
  preferences.getString("h_lecture");
}

@pragma('vm:entry-point')
Future<void> callbackDispatcher(int id, Map<String, dynamic> data) async {
  print("ipo kwenye combine...........................");
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    SharedPreferencesAndroid.registerWith();
  }
  if (Platform.isIOS) {
    SharedPreferencesIOS.registerWith();
  }
  DateTime day = DateTime.now();
  String today = DateFormat.EEEE().format(day);
  String td_time = DateFormat.Hm().format(day);
  if (data["notify"] != null) {
    if (data['combine'] == true) {
      if (data["c_days"] != null) {
        for (var c_day = 0; c_day < data["c_days"]!.length; c_day++) {
          if (data["c_days"]![c_day] == today) {
            var noww = DateTime.now();
            var splitted_now = noww.toString().split(" ");
            var splitted_now2 = noww.toString().split(" ");
            var dttt1;
            var dttt2;
            var dttttt1;
            var dttttt2;
            var category;
            var c_time = data['c_t_from']![c_day];
            c_time = "${c_time}:00";
            td_time = "${td_time}";

            splitted_now2[1] = c_time;
            dttt1 = splitted_now2;
            splitted_now[1] = td_time;
            dttt2 = splitted_now;
            dttttt1 = dttt1[0] + " " + dttt1[1];
            dttttt2 = dttt2[0] + " " + dttt2[1];
            DateTime dt1 = DateTime.parse(dttttt1);
            DateTime dt2 = DateTime.parse(dttttt2);
            Duration durr = dt1.difference(dt2);
            var time_category;
            var dataa = data['c_t_from']![c_day].split(":");
            if (int.parse(dataa[0]) >= 0 && int.parse(dataa[0]) < 12) {
              time_category = "AM";
            } else {
              time_category = "PM";
            }
            if (durr.inMinutes == data["notify"] ||
                durr.inMinutes == data['notify'] - 1) {
              setHomeNotification(
                  data["c_cozes"]![c_day],
                  '${data['c_t_from']![c_day]}-${data['c_t_to']![c_day]}',
                  '${data['c_days'][c_day]}',
                  '${data['c_venues'][c_day]}',
                  '${data['c_instructs'][c_day]}');
              getHomeNotification();
              PromodoroTimer().enterAtWork(
                  "After ${data["notify"]} minutes You Have Session to Attend",
                  "${data["c_cozes"]![c_day]}  ${data['c_t_from']![c_day]} $time_category  ${data["c_venues"]![c_day]}",
                  "before timetable",
                  "pristive",
                  "new Payload");
            }
            if (durr.inMinutes == 0) {
              PromodoroTimer().enterAtWork(
                  "Your Session time is ready! now",
                  "${data["c_cozes"]![c_day]}  ${data['c_t_from']![c_day]} $time_category  ${data["c_venues"]![c_day]}",
                  "exact timetable",
                  "pristive",
                  "new Payload");
            }
          }
        }
      }
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ModelTheme()),
      ],
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme value, child) => ScreenUtilInit(
                designSize: const Size(428, 926),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (context, child) {
                  return GetMaterialApp(
                    darkTheme: ThemeData.dark(),
                    themeMode: ThemeMode.system,
                    debugShowCheckedModeBanner: false,
                    title: 'UDOM Timetable',
                    theme: value.isDark
                        ? ThemeData(brightness: Brightness.dark)
                        : ThemeData(
                            textTheme: TextTheme(),
                            brightness: Brightness.light,
                            primaryColor: Colors.green,
                            primarySwatch: Colors.green),
                    home: SPlashscreen(),
                  );
                },
              )),
    );
  }
}
