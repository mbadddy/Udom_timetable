import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udom_timetable/layouts/Screens/Colors/themes.dart';

class ContentSlider extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const ContentSlider({super.key, required this.image, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.95,
        height: max(200, size.height * 0.32),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18),bottomRight: Radius.circular(18)),
            color: Colors.grey.withAlpha(90)),
        child: Stack(
          children: [
            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: ClipRRect(                
                borderRadius: BorderRadius.circular(18),
                child: Image(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 8, top: 8),
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.black.withAlpha(95)),
                child: Column(
                  children: [
                    Container(
                      height: 28,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: kAppTheme.textTheme.headline3,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.school,
                                color: kAppTheme.primaryColor,
                              ),
                              onPressed: () {

                              })
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [Text(subtitle,style: TextStyle(color:Colors.white),)],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));



// Padding(
//       padding: EdgeInsets.symmetric(horizontal: 13),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(image),
//           SizedBox(height: 30),
//           Text(
//             title,
//             style: TextStyle()
//                ),
//           SizedBox(height: 10),
//           Text(
//             subtitle,
//             style: TextStyle(color:Colors.black)

//           ),
//         ],
//       ),
//     );

  }
}