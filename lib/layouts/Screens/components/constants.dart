import 'package:flutter/material.dart';

class Constants {
  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  static List categories = [
    {
      'title': 'CIVE',
      'subtitle':'College Of Informatics And Virtual Eduaction',
      'image': 'assets/images/cive1.jpg',
      'color': Colors.purple
    },
    {
      'title': 'TIBA',
      'image':'assets/images/tiba1.jpg',
      'subtitle': 'College Of Health Science',
      'color': Colors.blue
    },
    {
      'title': 'COED', 
      'subtitle': 'College Of Education', 
      'image':'assets/images/education.jpg',
      'color': Colors.red},
    {
      'title': 'HUMANITY',
      'image':'assets/images/human.jpg',
      'subtitle': 'College Of Humanity nAnd Social science',
      'color': Colors.teal
    },
    {
      'title': 'COBE',
      'image':'assets/images/business.jpg',
      'subtitle': 'College Of Business And Economics',
      'color': Colors.pink
    },
    {
      'title': 'CNMS',
      'image':'assets/images/cnms.jpg',
       'subtitle': 'College Of Natural And Mathematical Science', 
       'color': Colors.green},
    {
      'title': 'COESE',
      'image':'assets/images/engineer.jpg',
      'subtitle': 'College Of Earth Science And Engineering',
      'color': Colors.green
    },
  ];

  static List sortList = [
    'File name (A to Z)',
    'File name (Z to A)',
    'Date (oldest first)',
    'Date (newest first)',
    'Size (largest first)',
    'Size (Smallest first)',
  ];
}
