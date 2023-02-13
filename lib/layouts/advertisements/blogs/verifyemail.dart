// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/login.dart';

class VerifyEmail extends StatefulWidget {
  final String email;
  final String phone;
  const VerifyEmail({
    Key? key,
    required this.email,
    required this.phone,
  }) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  Box<String>? otp_credential;
  bool isEmailVerified = false;
  Timer? timer;
  bool isMasgSent = false;
  void sendOTP(String phone) async {
   await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '$phone',
      verificationCompleted: (PhoneAuthCredential credential) {

         ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Account is successfully verified"))); 
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
            ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("The provided phone number is not valid.")));
        }
      },
      codeSent: (String verificationId, int? resendToken) {

           otp_credential!.put("myotp", "$verificationId");
           otp_credential!.get("myotp");
               ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Verification code is successfully sent to $phone")));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email Successfully Verified")));

      timer?.cancel();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoginPage(),
      ));
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
     otp_credential = Hive.box<String>("otp");
     if(Platform.isAndroid){
       sendOTP(widget.phone);
     }
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
          ),
             SizedBox(height: 5,),
              Padding(
            padding: EdgeInsets.all(20),
            child: Text("Resend An Verification Code if Not Sent to ${widget.phone} "),

          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: ElevatedButton(
                onPressed: () {
                  try {
                    sendOTP(widget.phone);
                  } catch (e) {
                    debugPrint('$e');
                  }
                },
                child: Text("Resend")),
          ),
        ],
      )),
    );
  }
}
