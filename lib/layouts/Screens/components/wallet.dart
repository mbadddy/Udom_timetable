// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/Screens/components/wallet_icons.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  
  @override
  Widget build(BuildContext context) {
     Color appbar=appColr;
     ThemeData deco=ThemeData.dark();
     Color deco2=Colors.white;
     final ThemeData mode = Theme.of(context);
    var whichMode=mode.brightness;
    if(whichMode==Brightness.dark){
     setState(() {
          appbar=Colors.black12;
          deco2=Colors.black45;
      });
}
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: appbar,
          borderRadius: BorderRadius.circular(25),
        ),
        height: 105,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: SingleChildScrollView(
                reverse: true,
                // physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: deco2,
                        ),
                        height: 75,
                        width: 125,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: deco2,
                        ),
                        height: 75,
                        width: 125,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.notifications_active,
                                      size: 18,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      'Today',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                             
                                const Text('CP 316            '),
                                const Text('08:00 AM         '),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const WalletIcons(icons: Icons.add, text: 'Combine', category: 'combine',),
            const WalletIcons(icons: Icons.remove_red_eye_outlined, text: 'View', category: 'view',),
            const WalletIcons(icons: Icons.roofing, text: 'venue', category: 'venue',),
          ],
        ),
      ),
    );
  }
}
