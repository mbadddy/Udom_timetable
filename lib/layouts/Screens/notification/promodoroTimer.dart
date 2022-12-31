import 'package:flutter/cupertino.dart';
import 'package:udom_timetable/layouts/Screens/notification/notification.dart';

class PromodoroTimer{
  enterAtWork(String title,String body,String channel,String sound,String payload){
  NotificationService().addNotification(title,
  body, DateTime.now().millisecondsSinceEpoch + 1000,
  channel,sound,payload);
  NotificationService().onselectedNotification(payload);
  }

}