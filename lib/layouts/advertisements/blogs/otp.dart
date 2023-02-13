// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/advertisements/animated/fadeanimations.dart';
import 'package:udom_timetable/layouts/advertisements/animated/hexcolors.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/screens/blog_create_blog.dart';

class OTP extends StatefulWidget {
  final String phone;
  const OTP({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  Box<String>? otp_credential;
  TextEditingController textEditingController = TextEditingController();
  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  String? verif_id;
  @override
  void initState() {
    otp_credential = Hive.box<String>("otp");
    verif_id = otp_credential!.get("myotp");
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
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
        title: Text("Verification"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.1, 0.4],
            colors: [
              log_page,
              input,
            ],
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                HexColor("#fff").withOpacity(0.2), BlendMode.dstATop),
            image: const NetworkImage(
              'https://mir-s3-cdn-cf.behance.net/project_modules/fs/01b4bd84253993.5d56acc35e143.jpg',
            ),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 1,
                  color:
                      const Color.fromARGB(255, 171, 211, 250).withOpacity(0.4),
                  child: Container(
                    width: 500,
                    padding: const EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FadeAnimation(
                          delay: 0.8,
                          child: Image.network(
                            "https://cdni.iconscout.com/illustration/premium/thumb/job-starting-date-2537382-2146478.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            child: Text(
                              "Let us help you",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  letterSpacing: 0.5),
                            ),
                          ),
                        ),
                        otp_credential == null
                            ? FadeAnimation(
                                delay: 1,
                                child: Container(
                                  child: Text(
                                    "It seems Like you doesn't receive Verification code",
                                    style: TextStyle(
                                        color: Colors.red.withOpacity(0.9),
                                        letterSpacing: 0.5),
                                  ),
                                ),
                              )
                            : Text(""),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Posts Verification',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8),
                          child: RichText(
                            text: TextSpan(
                                text: "Enter the code receive from ",
                                children: [
                                  TextSpan(
                                      text: "Administrator",
                                      style: TextStyle(
                                          color: log_txt,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ],
                                style: TextStyle(color: log_txt, fontSize: 15)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: formKey,
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 6,
                            obscureText: true,
                            obscuringCharacter: '*',
                            obscuringWidget: const Icon(
                              Icons.pets,
                              color: Colors.blue,
                              size: 24,
                            ),
                            blinkWhenObscuring: true,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v!.length < 3) {
                                return "Validate me";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 40,
                                activeFillColor: Colors.white,
                                inactiveFillColor: Colors.white),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: textEditingController,
                            keyboardType: TextInputType.number,
                            boxShadows: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                            onCompleted: (v) {
                              debugPrint("Completed");
                            },
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (value) {
                              debugPrint(value);
                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            hasError
                                ? "*Please fill up all the cells properly"
                                : "",
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't receive the code? ",
                              style: TextStyle(color: log_txt, fontSize: 15),
                            ),
                            TextButton(
                              onPressed: () {
                                sendOTP(widget.phone);
                                snackBar("OTP resend!!");
                              },
                              child: const Text(
                                "RESEND",
                                style: TextStyle(
                                    color: Color(0xFF91D3B3),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: TextButton(
                              onPressed: () {
                                formKey.currentState!.validate();
                                // conditions for validating
                                if (currentText.length != 6) {
                                  errorController!.add(ErrorAnimationType
                                      .shake); // Triggering error shake animation
                                  setState(() => hasError = true);
                                } else {
                                    snackBar("OTP veriry!!");
                                  verifyOTP(currentText);
                                }
                              },
                              child: Text(
                                "Verify",
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFF2697FF),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0, horizontal: 80),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)))),
                        ),
                      ],
                    ),
                  ),
                ),

                //End of Center Card
                //Start of outer card
                const SizedBox(
                  height: 20,
                ),

                FadeAnimation(
                  delay: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Want to try again? ",
                          style: TextStyle(
                            color: appbar,
                            letterSpacing: 0.5,
                          )),
                      GestureDetector(
                        onTap: () async {
                          try {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pop(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'connection problem while logging out'),
                                duration: Duration(milliseconds: 1500),
                                width: 280.0,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                          Navigator.pop(context);
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (context) {
                          //   return LoginScreen();
                          // }));
                        },
                        child: Text("Sing in",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
   bool isPhone(String? value) =>value.toString().startsWith("+255",0);
 String myPhone(String? value) =>
      value.toString().replaceAll(value.toString().substring(0,1), "+255").toString();
  String checkPhone(phone){
    String myphone="";
       if(!isPhone(phone)){
       myphone=myPhone(phone);
       print("inareplaciwa");
       return myphone;
     }
     return phone;
  }
  void sendOTP(String phone) async {
    phone=checkPhone(phone);
    await FirebaseAuth.instance.verifyPhoneNumber(
      timeout: Duration(seconds:10),
      phoneNumber: '$phone',
      verificationCompleted: (PhoneAuthCredential credential) {
              snackBar("Account is successfully verified $phone");
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
              snackBar("The provided phone number is not valid. $phone");
        }
         snackBar("otp send failed.....${e.code}");
        
      },
      codeSent: (String verificationId, int? resendToken) {
        otp_credential!.put("myotp", "$verificationId");
        otp_credential!.get("myotp");
          snackBar("Verification code is successfully sent to $phone....");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP(String currentText) async {
    try {
      if (otp_credential!.get("myotp") != null) {
        // sendOTP(widget.phone);
        FirebaseAuth auth = FirebaseAuth.instance;
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: otp_credential!.get("myotp")!, smsCode: currentText);
        await auth.signInWithCredential(credential);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateBlog(),));
        setState(
          () {
            hasError = false;
            snackBar("OTP Verified!!");
          },
        );
      }
      else{
        sendOTP(widget.phone);
      }
    } catch (e) {
         snackBar("OTP is incorrect!!");
    }
  }
}
