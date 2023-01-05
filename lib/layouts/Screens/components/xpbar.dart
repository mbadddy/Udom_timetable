// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';

class XpBar extends StatefulWidget {
   final BannerAd banner;
   final bool isLoaded;
  const XpBar({
    Key? key,
    required this.banner,
    required this.isLoaded,
  }) : super(key: key);

  @override
  State<XpBar> createState() => _XpBarState();
}

class _XpBarState extends State<XpBar> {


  @override
  Widget build(BuildContext context) {
      List<Color> appbar=[Color.fromARGB(255, 184, 241, 186), Colors.white];
       Color card_color= Colors.transparent;
        Color shadow=Colors.grey;
 final ThemeData mode = Theme.of(context);
  var whichMode=mode.brightness;
 if(whichMode==Brightness.dark){
  setState(() {
          appbar=[Colors.black12,Colors.black12];
          card_color=Colors.black26;
          shadow=Colors.black12;
      });
}
    return widget.isLoaded? Container(
      // width: double.infinity,
     width: widget.banner.size.width.toDouble(),
      height: widget.banner.size.height.toDouble(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.center,
            colors: appbar),
        boxShadow:  [
          BoxShadow(color: shadow, blurRadius: 2),
        ],
      ),
      child: AdWidget(ad: widget.banner)
    ):
    Text("");
  }
}
