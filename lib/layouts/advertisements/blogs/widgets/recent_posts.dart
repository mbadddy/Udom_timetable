// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:udom_timetable/layouts/advertisements/blogs/models/blog_model.dart';

class RecentPosts extends StatelessWidget {
  Color backgrnd;
  Color b_white;
  RecentPosts({
    Key? key,
    required this.backgrnd,
    required this.b_white,
  }) : super(key: key);
  @override 

  Widget build(BuildContext context) {
    
    return Container(
      color: backgrnd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: blogs.map((blog) =>
          Container(
            margin: EdgeInsets.only(bottom: 15.0),
            width: MediaQuery.of(context).size.width,
            height: 140,
            decoration: BoxDecoration( 
              color: backgrnd,
              
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.22,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        image: AssetImage(blog.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.66, 
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5.0),
                        Text(
                          blog.author.name,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          height: 65,
                          child: Text(
                            blog.name,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: b_white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.timer,
                                  color: Colors.grey,
                                  size: 12.0,
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  blog.created_at,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 20.0),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.grey,
                                  size: 12.0,
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  "7k Views",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ).toList()
      ),
    );
  }
}
