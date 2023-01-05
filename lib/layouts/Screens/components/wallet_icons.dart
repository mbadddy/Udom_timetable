// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/Exams_Tests/exam_table.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/combine/combine_table.dart';
import 'package:udom_timetable/storage/create.dart';
class WallerrIcons extends StatefulWidget {
  final IconData icons;
  final String text;
  final String category;
  const WallerrIcons({
    Key? key,
    required this.icons,
    required this.text,
    required this.category,
  }) : super(key: key);


  @override
  State<WallerrIcons> createState() => _WallerrIconsState();
}

class _WallerrIconsState extends State<WallerrIcons> {
  
  popup(){
     print("hellow...................");
     showDialog(context: context, builder: (context) {
     return const Dialog(child: Text("hellow how are you"),);
  },);
}
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.category=="combine"?
        GestureDetector(
          onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => Combine(),)),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Icon(
              size: 30,
              widget.icons,
              color: const Color(0xff0081A0),
            ),
          ),
        ):
         GestureDetector(
          onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => Exams(),)),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Icon(
              size: 30,
              widget.icons,
              color: const Color(0xff0081A0),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.text,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}




