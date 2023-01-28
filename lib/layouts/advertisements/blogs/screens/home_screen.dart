
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/login.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/screens/blog_create_blog.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/widgets/blog_posts.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/widgets/fav_authors.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/widgets/recent_posts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences? sharedPreferences;
    var token;
     var token_refresh;
  Future getTokens()async{
    sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      token=sharedPreferences!.getString("token");
      token_refresh=sharedPreferences!.getString("token_refresh");
    });
  }
   @override
  void initState() {
    getTokens();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    getTokens();
        Color appbar=appColr;
         Color appbar2=appColr2;
         Color log_page=Colors.white;
         Color log_txt=Colors.black87;
         Color input=Colors.white;
   
   
 final ThemeData mode = Theme.of(context);
var whichMode=mode.brightness;
if(whichMode==Brightness.dark){
  setState(() {
          appbar=Colors.black;
          appbar2=Colors.black38;
          log_page=Colors.black26;
          log_txt=Colors.white;
          input=Colors.black54;
      });
}
    return Scaffold(
      backgroundColor: log_page,
      body: SafeArea(
        child: ListView(
          children: <Widget>[ 
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Udom Blogs",
                    style: TextStyle(
                      color: log_txt,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        size: 30.0,
                        color: log_txt,
                      ),
                     IconButton(onPressed: () {
                       if(token==null || token_refresh==null){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage(),));
                       }
                       else{
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateBlog(refresh_token: token_refresh, token: token,),));
                       }
                     
                     }, icon: Icon(Icons.add,size: 30,color: appColr))
                    ],
                  )
                ],
              ), 
            ),
            Column(
              children: <Widget>[
                // FavAuthors(), 
                BlogPosts(backgrnd: log_page, b_white: log_txt,), 
                Container(
                  color: log_page,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Recent Posts",
                          style: TextStyle(
                            color: log_txt,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "See all",
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 16.0
                          ),
                        )
                      ],
                    ),
                  ),
                ), 
                RecentPosts(backgrnd: log_page, b_white: log_txt,)
              ],
            ) 
          ],
        ),
      ),
    );
  }
}