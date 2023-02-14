// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/advertisements/animated/fadeanimations.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
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
          title: Text("Information"),
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
        body: SizedBox(
          width: MediaQuery.of(context).size.width * 0.99,
          height: MediaQuery.of(context).size.width * 0.99,
          child: FlipCard(
              direction: FlipDirection.VERTICAL,
              front: ReusableCard(
                text: Column(
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
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Account Activation issue',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    FadeAnimation(
                      delay: 1,
                      child: Container(
                        child: Text(
                          "Please Contact The Followings!!",
                       
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    FadeAnimation(
                      delay: 1,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              "Anuary Issa",
                       
                            ),
                            Text(
                              "+255734328981",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Brighton Fredrick",
                            ),
                            Text(
                              "+255762311925"
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: FadeAnimation(
                                delay: 1,
                                child: Container(
                                  child: Text(
                                    "Click me for more information",
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              back: ReusableCard(
                text: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeAnimation(
                      delay: 1,
                      child: Container(
                        child: Text(
                          "Let us help you",
                           style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeAnimation(
                      delay: 1,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              "Anuary Issa",
                            ),
                            Text(
                              "anuaryissa21@gmail.com",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Brighton Fredrick",
                            ),
                            Text(
                              "fredrickbrighton@gmail.com",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: FadeAnimation(
                                delay: 1,
                                child: Container(
                                  child: Text(
                                    "Click me for more information",

                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}

class Flashcard {
  final String question;
  final Color txtcolor;

  Flashcard({required this.question, required this.txtcolor});
}

class ReusableCard extends StatelessWidget {
  ReusableCard({
    Key? key,
    required this.text,
  }) : super(key: key);
  final Widget text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 8,
        shadowColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(child: text),
        ),
      ),
    );
  }
}
