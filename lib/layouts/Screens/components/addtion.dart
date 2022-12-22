import 'dart:math';

import 'package:flutter/material.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';

class Addition extends StatefulWidget {
  const Addition({Key? key}) : super(key: key);

  @override
  State<Addition> createState() => _AdditionState();
}

class _AdditionState extends State<Addition> {
  @override
  Widget build(BuildContext context) {
        Color appbar=Colors.transparent;
        Color slider=Colors.white;
        Color shadow=Colors.grey;
  
      final ThemeData mode = Theme.of(context);
       var whichMode=mode.brightness;
       if(whichMode==Brightness.dark){
        setState(() {
          appbar=Colors.black12;
          slider=Colors.black12;
          shadow=Colors.black12;
        });
       }
    return Container(
        height: 100,
        width: double.infinity,
        decoration:  BoxDecoration(
          color: appbar,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: ListView(
              // physics: const ClampingScrollPhysics(),
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () => print('vouchers'),
                  child: Container(
                    width: 235,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: slider,
                      boxShadow:  [
                        BoxShadow(color: shadow, blurRadius: 2),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '21 vouchers expiring soon',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.7),
                          ),
                          SizedBox(
                              child: Image.asset(
                            'assets/images/icon voucher.png',
                            scale: 2.1,
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () => print('Nearest Restos'),
                  child: Container(
                    width: 235,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: slider,
                      boxShadow:  [
                        BoxShadow(color: shadow, blurRadius: 2),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Restos near me',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.7),
                          ),
                          SizedBox(
                              child: Image.asset(
                            'assets/images/icon gofood flat.png',
                            scale: 2.1,
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
        ));
  }
}
