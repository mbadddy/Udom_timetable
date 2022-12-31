import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;
import 'package:rxdart/subjects.dart';
class NotificationService{

  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> onclickNotifiation=BehaviorSubject();

  Future<void> setup() async {
  // #1 
  const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosSetting = IOSInitializationSettings(requestSoundPermission: true);

  // #2
  const initSettings =
      InitializationSettings(android: androidSetting, iOS: iosSetting);

  // #3
  await _localNotificationsPlugin.initialize(initSettings,onSelectNotification: onselectedNotification).then((_) {
     print('setupPlugin: setup success');
  }).catchError((Object error) {
      print('Error: $error');
  });
}


Future addNotification(String title,String body,int endTime,channename,String sound,String payload) async{
  
  // #1
tzData.initializeTimeZones();
var dar = tz.getLocation('Africa/Dar_es_Salaam');
tz.setLocalLocation(dar);
  var now = tz.TZDateTime.now(dar);
// var zone = tz.getLocation('Africa/Algiers');
//   tz.TZDateTime.from(DateTime.now(), zone);
// tz.TZDateTime scheduleTime =
//   tz.TZDateTime.from(DateTime.now(), zone);

// #2
var soundFile = sound.replaceAll('.mp3', '');

// #2 
final notificationSound =
    sound == '' ? null : RawResourceAndroidNotificationSound(soundFile);
final androidDetail = AndroidNotificationDetails(
  '0', // channel Id
  channename ,
  channelDescription: "description",
  importance: Importance.max,
  playSound: true,
  sound:notificationSound ,
  colorized: true,
  color: Colors.transparent// channel Name
);

// final iosDetail ==sound=='' ?null: IOSNotificationDetails();
final iosDetail = sound == ''
    ? null
    : IOSNotificationDetails(presentSound: true, sound: sound);
final noticeDetail = NotificationDetails(
  iOS: iosDetail,
  android: androidDetail,
);
    
// #3
final id = 0;

// #4
await _localNotificationsPlugin.zonedSchedule(
  id,
  title,
  body,
  payload:payload,
  tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  noticeDetail,
  uiLocalNotificationDateInterpretation:
     UILocalNotificationDateInterpretation.absoluteTime,
  androidAllowWhileIdle: true,
);

}
void cancelAllNotification() {
  _localNotificationsPlugin.cancelAll();
}
void cancelByIdNotification(int notifyid) {
  _localNotificationsPlugin.cancel(notifyid);
}
void onselectedNotification(String? payload){
  print("payload $payload................");
  if(payload!=null && payload.isNotEmpty){
    onclickNotifiation.add(payload);
  }
}
}