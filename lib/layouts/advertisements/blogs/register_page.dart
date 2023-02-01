import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/verifyemail.dart';

import '../../Screens/Colors/colors.dart';
import '../constants/constant.dart';
import 'animated_row.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController emailTFieldController = TextEditingController();
  TextEditingController typeTFieldController = TextEditingController();
  TextEditingController confirm = TextEditingController();
  String imageFileController = '';
  bool registeAttempt=false;
  final _formKey = GlobalKey<FormState>();
  String message='';
bool isEmail(String? value) =>
      value!.isEmpty ||
      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);
 bool isPassword(String? value) =>
      value!.isEmpty || value.length<7 ||
      !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(value);
bool itMatch(String? value)=>value!=typeTFieldController.text;
  @override
  void dispose() {
    emailTFieldController.dispose();
    typeTFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
             Color appbar=appColr;
         Color appbar2=appColr2;
         Color log_page=Colors.white;
         Color log_txt=Colors.black87;
         Color input=Colors.white;
   
   
 final ThemeData mode = Theme.of(context);
var whichMode=mode.brightness;
if(whichMode==Brightness.dark){
  setState(() {
          appbar=Colors.black12;
          appbar2=Colors.black38;
          log_page=Colors.black26;
          log_txt=Colors.white;
          input=Colors.black54;
      });
}
    return  Scaffold(
        appBar: AppBar(backgroundColor: appbar,
        centerTitle: true,
        title: Text("Registration"),
      leading: IconButton(onPressed: () {
        Navigator.of(context).pop();
      }, icon: Icon(Icons.arrow_back_ios_new)),),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Enter Your Credentials',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
          
                  const Divider(),
                  AnimatedRow(
                    title: 'email',
                    controller: emailTFieldController,
                    validator: (value) =>
                        isEmail(value.toString().trim()) ? 'email is incorrect' : null,
                    isEditable: false, type: TextInputType.emailAddress, obcure: false,
                  ),
                  AnimatedRow(
                    title: 'Password',
                    controller: typeTFieldController,
                    validator: (value) => isPassword(value.toString().trim())
                        ? 'weak passowrd'
                        : null,
                    isEditable: false, type: TextInputType.visiblePassword, obcure: true,
                  ),
                  AnimatedRow(
                    title: 'Pass Confirm',
                    controller: confirm,
                    validator: (value) => itMatch(value.toString().trim())
                        ? "doesn't match"
                        : null,
                    isEditable: false, type: TextInputType.visiblePassword, obcure: true,
                  ),
                  const Divider(),
                 message.isNotEmpty?
                   Text(
                    '${message}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.red),
                  ):Text(''),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: mainBackupColor),
                    ),
                  )),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: appbar,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  setState(() {
                    registeAttempt=true;
                  });
                   if(_formKey.currentState!.validate()){
                       registerUser(emailTFieldController.text,confirm.text);
                      
                   }
                
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: MediaQuery.of(context).size.width * 0.15),
                  child: registeAttempt?
                  const CircularProgressIndicator():
                  const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ;
  }
  
  Future<void> registerUser(String emailAddress, String password) async {
     try {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailAddress,
    password: password,
  );
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => VerifyEmail(email: emailAddress,),));

} on FirebaseAuthException catch (e) {
  setState(() {
     registeAttempt=false;
  });
  if (e.code == 'weak-password') {
    setState(() {
      message="The password provided is too weak.";
    });
   
  } else if (e.code == 'email-already-in-use') {
    setState(() {
    message="The account already exists for that email.";
    });
    
  
  }
} catch (e) {

  setState(() {
    registeAttempt=false;
     message="connection problem";
  });
   
  print(e);
}
  }
  
}
