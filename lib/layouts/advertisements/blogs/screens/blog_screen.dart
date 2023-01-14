// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:udom_timetable/layouts/advertisements/blogs/models/blog_model.dart';

class BlogScreen extends StatefulWidget {
   Color backgrnd;
  final Blog blog;
  Color b_white;
  BlogScreen({
    Key? key,
    required this.backgrnd,
    required this.blog,
    required this.b_white,
  }) : super(key: key);
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgrnd,
      body: ListView(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(  
                    height: MediaQuery.of(context).size.height * 0.45, 
                    child: ClipRRect(
                      child: Image(
                        image: AssetImage(widget.blog.imageUrl), 
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned( 
                    bottom: 0,
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: widget.backgrnd,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60.0),
                          topRight: Radius.circular(60.0)
                        ),
                      ),
                      child: SizedBox(width: 1),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon : Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Icon(
                            Icons.bookmark_border,
                            color: Colors.white,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 700,
              decoration: BoxDecoration( 
                color: widget.backgrnd,
              ),
              child:
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child:ListView(
                  children: <Widget>[
                    Text(
                      widget.blog.name,
                      style: TextStyle(
                        fontSize: 28.0,
                        color: widget.b_white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "⭐ 4.5",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.timer,
                              color: Colors.grey,
                              size: 16.0,
                            ),
                            SizedBox(width: 2.0),
                            Text(
                              widget.blog.created_at,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0
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
                              size: 16.0,
                            ),
                            SizedBox(width: 2.0),
                            Text(
                              "7k Views",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage(widget.blog.author.imageUrl),
                          radius: 28.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          widget.blog.author.name,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Expanded(
                      child: 
                      Padding(padding: EdgeInsets.only(bottom: 15),
                      child:  Text(
                      widget.blog.content,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey,
                        letterSpacing: 1
                      ),
                    ),)
                     )
                    
                  ],
                ),
                
              ),
            )
            ,
           
          ],
        ),
   
    );
  }
}