// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/combine/combine_table.dart';
import 'package:udom_timetable/storage/create.dart';

class WalletIcons extends StatelessWidget {
  final IconData icons;
  final String text;
  final String category;

  const WalletIcons({
    Key? key,
    required this.icons,
    required this.text,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        category=="combine"?
        GestureDetector(
          onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => Combine(),)),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Icon(
              size: 30,
              icons,
              color: const Color(0xff0081A0),
            ),
          ),
        ):
       category=="venue"? 
       GestureDetector(
          onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => Users(),)),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Icon(
              size: 30,
              icons,
              color: const Color(0xff0081A0),
            ),
          ),
        ):
         category=='view'?  GestureDetector(
          onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => Users(),)),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Icon(
              size: 30,
              icons,
              color: const Color(0xff0081A0),
            ),
          ),
        ):
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
