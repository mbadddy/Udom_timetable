import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/login.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/screens/allposts.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/screens/blog_create_blog.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/widgets/blog_posts.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/widgets/recent_posts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> myblogs;
  late Stream<QuerySnapshot<Map<String, dynamic>>> pop_blogs;
  @override
  void initState() {
    myblogs = FirebaseFirestore.instance
        .collection('blogg')
        .orderBy("created", descending: true)
        .limit(10)
        .snapshots();

    pop_blogs = FirebaseFirestore.instance
        .collection('blogg')
        .orderBy("viewers", descending: true)
        .limit(10)
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   myblogs = FirebaseFirestore.instance
    //       .collection('blogs')
    //       .orderBy("doc_id", descending: false).limit(10)
    //       .snapshots();
    // });
    Color appbar = appColr;
    Color appbar2 = appColr2;
    Color log_page = Colors.white;
    Color log_txt = Colors.black87;
    Color input = Colors.white;

    final ThemeData mode = Theme.of(context);
    var whichMode = mode.brightness;
    if (whichMode == Brightness.dark) {
      setState(() {
        appbar = Colors.black;
        appbar2 = Colors.black38;
        log_page = Colors.black26;
        log_txt = Colors.white;
        input = Colors.black54;
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
                  Text("Udom Blogs",
                      style: TextStyle(
                          color: log_txt,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold)),
                  Row(
                    children: <Widget>[
                      IconButton(
                          onPressed: () async {
                            if (await FirebaseAuth.instance.currentUser !=
                                null) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CreateBlog()));
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                            }
                          },
                          icon: Icon(Icons.add, size: 30, color: appColr))
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                // FavAuthors(),

                Container(
                  color: log_page,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Popular Posts",
                          style: TextStyle(
                              color: log_txt,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AllPosts(title: "Popular Posts"),
                            ));
                          },
                          child: Text(
                            "See all",
                            style: TextStyle(
                                color: Colors.lightBlueAccent, fontSize: 16.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                BlogPosts(
                  backgrnd: log_page,
                  b_white: log_txt,
                  myblogs: pop_blogs,
                ),
                Container(
                  color: log_page,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Recent Posts",
                          style: TextStyle(
                              color: log_txt,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AllPosts(title: "All Posts"),
                            ));
                          },
                          child: Text(
                            "See all",
                            style: TextStyle(
                                color: Colors.lightBlueAccent, fontSize: 16.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                RecentPosts(
                  backgrnd: log_page,
                  b_white: log_txt,
                  myblogs: myblogs,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
