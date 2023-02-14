import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/admin/Posts/posts.dart';
import 'package:udom_timetable/layouts/admin/admincard.dart';
import 'package:udom_timetable/layouts/admin/manageusers.dart';

class AdminContainer extends StatefulWidget {
  const AdminContainer({super.key});

  @override
  State<AdminContainer> createState() => _AdminContainerState();
}

class _AdminContainerState extends State<AdminContainer> {
  CollectionReference allusers = FirebaseFirestore.instance.collection('users');
  Query<Map<String, dynamic>> activeusers = FirebaseFirestore.instance
      .collection('users')
      .where("active", isEqualTo: true);
  List<String> options = ['posts', "disable all"];
  var total = 0;
  var active = 0;
   var disabled = 0;
  
  @override
  Widget build(BuildContext context) {
    allusers.get().then(
      (value) {
        setState(() {
          total = value.docs.length;
        });
      },
    );
    activeusers.get().then(
      (value) {
        setState(() {
          active = value.docs.length;
        });
      },
    );
    setState(() {
      disabled=int.parse(total.toString())-int.parse(active.toString());
    });
    Color appbar = appColr;

    final ThemeData mode = Theme.of(context);
    var whichMode = mode.brightness;
    if (whichMode == Brightness.dark) {
      setState(() {
        appbar = Colors.black12;
      });
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appbar,
          centerTitle: true,
          title: Text("Admin"),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new)),
          actions: [
            IconButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('connection problem while logging out'),
                        duration: Duration(milliseconds: 1500),
                        width: 280.0,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                icon: Icon(Icons.logout)),
           
          ],
        ),
        body: Column(
          children: [
            AdminCard(total: "${total}", active: "$active", deactive: "$disabled"),
            Expanded(child: ManageUsers()),
          ],
        ));
  }
}
