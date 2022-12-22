import 'package:flutter/material.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';

class XpBar extends StatefulWidget {
  const XpBar({Key? key}) : super(key: key);

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
    return Container(
      // width: double.infinity,
      height: 70,
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
      child: Stack(
        children: [
          Image.asset(
            'assets/images/gocluppoinbar.png',
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: card_color,
            ),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 45,
                  child: Image.asset(
                    'assets/images/GO-CLUB1.png',
                    // color: Colors.orange,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '111 XP your next treasure',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Stack(children: [
                      Container(
                        height: 4,
                        width: 245,
                        decoration: BoxDecoration(
                            color: shadow,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Container(
                        height: 4,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)),
                      )
                    ]),
                  ],
                ),
                GestureDetector(
                  onTap: () => print('GoClub XP'),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
