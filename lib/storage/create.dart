
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/services/Modal/timetable.dart';
import 'package:udom_timetable/services/timetable_Service.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final TextEditingController id=TextEditingController();
  final TextEditingController name=TextEditingController();
  Box<String>? userbox;
   TimetableService service=TimetableService();
    late Future<Timetable> timetable;
    //internet checker
StreamSubscription? connection;
bool isoffline = true;

 
  @override
  void initState() {
    timetable=service.fetchTimetable();
    userbox=Hive.box<String>("users");
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
        title:new Text("Operations"),
        
        backgroundColor: appbar,
        actions: [
       
        ],
        
      ),
      body: Padding(padding: EdgeInsets.all(10),
      child: Column(
        children: [
          
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: userbox!.listenable(),
              builder: (context, Box<String> users, child) {
               return ListView.separated(
                itemBuilder: (context, index){
                    final key=users.keys.toList();
                   
                    final value=users.get(key[index]);
                    
                    return ListTile(
                      title: Text(key[index]!,
                      style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(value!,
                      ),
                    );
               } , 
               separatorBuilder: (context, index) => Divider(),
                itemCount: users.keys.toList().length,);
              
            },)
          ),
      Expanded(child:
      FutureBuilder<Timetable>(
       future: timetable,
       builder: (context, snapshot) {

         if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.data.length,
            itemBuilder: (context, index) {
              
            return 
            ListTile(
              leading: Text(snapshot.data!.data[index].course),
              title: Text(snapshot.data!.data[index].instructor),
              subtitle: Text(snapshot.data!.data[index].venue),
              trailing: Text(snapshot.data!.data[index].day.toString()),
            );
          },);
    } 
    else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }

    // By default, show a loading spinner.
    return const CircularProgressIndicator();
          },
            )) ,  
    
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: () {
                 showDialog(
                  context: context, builder: (context) {
                    return Dialog(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: id,
                              decoration: InputDecoration(
                                labelText: "ID",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                                  TextField(
                              controller: name,
                              decoration: InputDecoration(
                                labelText: "Name",
                                border: OutlineInputBorder(),
                              ),
                            ),
                             const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(onPressed:() {
                              final idd=id.text;
                              final nam=name.text;
                              userbox!.put(idd, nam);
                              print("success");
                              // print(Box<String>.keys.toList().length);
                              Navigator.pop(context);
                            },child: Text("submit"))
                          ],
                        ),
                      ),
                    );
                  });
              }, child: Text("Add User")),
                  ElevatedButton(onPressed: () {
                          showDialog(
                  context: context, builder: (context) {
                    return Dialog(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: id,
                              decoration: InputDecoration(
                                labelText: "ID",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                                  TextField(
                              controller: name,
                              decoration: InputDecoration(
                                labelText: "Name",
                                border: OutlineInputBorder(),
                              ),
                            ),
                             const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(onPressed:() {
                              final idd=id.text;
                              final nam=name.text;
                              final user=userbox!.get(idd);
                             
                              if(user==null){
                                print("No Such User");
                              }
                              else{
                                userbox!.put(idd, nam);
                              print("success updated");
                              }
                             
                              // print(Box<String>.keys.toList().length);
                              Navigator.pop(context);
                            },child: Text("update"))
                          ],
                        ),
                      ),
                    );
                  });
                
              }, child: Text("Update User")),
                  ElevatedButton(onPressed: () {
                     showDialog(
                  context: context, builder: (context) {
                    return Dialog(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: id,
                              decoration: InputDecoration(
                                labelText: "ID",
                                border: OutlineInputBorder(),
                              ),
                            ),
                         const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(onPressed:() {
                              final idd=id.text;
                              userbox!.delete(idd);
                              print("success deleted");
                              // print(Box<String>.keys.toList().length);
                              Navigator.pop(context);
                            },child: Text("delete"))
                          ],
                        ),
                      ),
                    );
                  });

              }, child: Text("Delete User")),
            ],
          )
        ],
      )
      ,),

    );
  }
}