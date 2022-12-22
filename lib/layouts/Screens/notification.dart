import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
    return Container(child:favourate==null?Center(child: Text("No Favourate Availbale Please Select"),): 
    Center(child: Text("This is Notification for ${sharedPreferences!.getString("college")}"),),);
  }
}