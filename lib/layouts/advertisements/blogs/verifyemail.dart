// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/login.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/screens/blog_create_blog.dart';

class VerifyEmail extends StatefulWidget {
  final String email;
  const VerifyEmail({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  Timer? timer;
  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email Successfully Verified")));
      
      timer?.cancel();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage(),));
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color appbar = appColr;
    Color appbar2 = appColr2;
    Color log_page = Colors.white;
    Color log_txt = Colors.black87;
    Color input = Colors.white;

    final ThemeData mode = Theme.of(context);
    var whichMode = mode.brightness;
    if (whichMode == Brightness.dark) {
      setState(() {
        appbar = Colors.black12;
        appbar2 = Colors.black38;
        log_page = Colors.black26;
        log_txt = Colors.white;
        input = Colors.black54;
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbar,
        centerTitle: true,
        title: Text("Verify Email"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
              "We have Sent Email to ${FirebaseAuth.instance.currentUser?.email}"),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text("Resend An Email You doesn't see Link in yor email"),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: ElevatedButton(
                onPressed: () {
                  try {
                    FirebaseAuth.instance.currentUser?.sendEmailVerification();
                  } catch (e) {
                    debugPrint('$e');
                  }
                },
                child: Text("Resend")),
          )
        ],
      )),
    );
  }
}
