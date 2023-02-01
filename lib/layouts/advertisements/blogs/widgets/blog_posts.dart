// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:platform_device_id/platform_device_id.dart';

import 'package:udom_timetable/layouts/advertisements/blogs/screens/blog_screen.dart';

class BlogPosts extends StatelessWidget {
  Color backgrnd;
  Color b_white;
  Stream<QuerySnapshot<Map<String, dynamic>>> myblogs;
  BlogPosts({
    Key? key,
    required this.backgrnd,
    required this.b_white,
    required this.myblogs,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder(
            stream: myblogs,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              } else {
                Center(child: Text("No data is available"));
              }
              if (snapshot.hasData) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  height: MediaQuery.of(context).size.width * 0.90,
                  color: backgrnd,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final QueryDocumentSnapshot<Map<String, dynamic>> blog =
                          snapshot.data!.docs[index];
                      return GestureDetector(
                        onTap: () {
                          catchViewer(blog['doc_id']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlogScreen(
                                        blog: blog,
                                        backgrnd: backgrnd,
                                        b_white: b_white,
                                      )));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, top: 20.0, bottom: 20.0),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.80,
                                  height:
                                      MediaQuery.of(context).size.width * 0.90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.0),
                                      color: backgrnd,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0.0, 4.0),
                                            blurRadius: 10.0,
                                            spreadRadius: 0.10)
                                      ]),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14.0),
                                    child: Image(
                                      image: NetworkImage(blog['blog']),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Positioned(
                                bottom: 10.0,
                                left: 10.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.60,
                                      child: Text(
                                        blog["title"],
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.6,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        CircleAvatar(
                                            radius: 10.0,
                                            backgroundImage:
                                                NetworkImage(blog['user'])),
                                        SizedBox(width: 8.0),
                                        Text(blog['author_name'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 10.0,
                                right: 10.0,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.timer,
                                      size: 10.0,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5.0),
                                    Duration(
                                                    minutes: DateTime.parse(
                                                            DateFormat("yyyy-MM-dd hh:mm:ss").format(
                                                                DateTime.now()))
                                                        .difference(DateTime.parse(
                                                            blog['created']
                                                                .toString()))
                                                        .inMinutes)
                                                .inMinutes >=
                                            60
                                        ? Duration(
                                                        hours: DateTime.parse(DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()))
                                                            .difference(DateTime.parse(blog['created'].toString()))
                                                            .inHours)
                                                    .inHours >=
                                                24
                                            ? Duration(days: DateTime.parse(DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays >= 7
                                                ? (Duration(days: DateTime.parse(DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 7).floor() >= 4
                                                    ? (Duration(days: DateTime.parse(DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 7).floor() >= 48
                                                        ? Text(
                                                            "${(Duration(days: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 336).floor()} yrs ago",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          )
                                                        : Text(
                                                            "${(Duration(days: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 28).floor()} months ago",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          )
                                                    : Text(
                                                        "${(Duration(days: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 7).floor()} weeks ago",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                        ),
                                                      )
                                                : Text(
                                                    "${Duration(days: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays % 7} days ago",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                            : Text(
                                                "${Duration(hours: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inHours).inHours} hrs ago",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              )
                                        : Text(
                                            "${Duration(minutes: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inMinutes).inMinutes} min ago",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          )
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 10.0,
                                right: 10.0,
                                child: Icon(Icons.bookmark,
                                    size: 26.0, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                Text("No data is available");
              }
              return Center(child: const CircularProgressIndicator());
            }),
        SizedBox(height: 5.0)
      ],
    );
  }

  catchViewer(blog) async {
    final firebase =
        FirebaseFirestore.instance.collection("blogs").doc("$blog");
    DocumentReference ref =
        FirebaseFirestore.instance.collection("blogs").doc("$blog");
    String viewers = await ref.get().then(
      (DocumentSnapshot value) {
        return value.get("viewers").toString();
      },
    );
    String doc_id = await ref.get().then(
      (DocumentSnapshot value) {
        return value.get("doc_id").toString();
      },
    );
    final data = {"viewers": int.parse("$viewers") + 1};
    String dev_id = await getDeviceInfo();
    Box<List<String>>? deleteed = Hive.box<List<String>>("del_docs");
    List<String>? device_views = [];
    List<String>? views = deleteed.get("$dev_id");
    print("device id $dev_id");
    if (views != null) {
      if (!views.contains(doc_id.toString())) {
        for (var x = 0; x < views.length; x++) {
          device_views.add(views[x]);
        }
        device_views.add(doc_id.toString());
        deleteed.put("$dev_id", device_views);
        ref.update(data);
        print("device $dev_id doc $doc_id views ${int.parse("$viewers") + 1}");
        print("all views ${deleteed.get("$dev_id")}");
      } else {
        if (views.isEmpty) {
          device_views.add(doc_id);
          deleteed.put("$dev_id", device_views);
          ref.update(data);
          print(
              "device $dev_id doc $doc_id views ${int.parse("$viewers") + 1}");
        }
      }
    } else {
      device_views.add(doc_id);
      deleteed.put("$dev_id", device_views);
      ref.update(data);
      print("device $dev_id doc $doc_id views ${int.parse("$viewers") + 1}");
    }
  }

  Future<String> getDeviceInfo() async {
    String? result = await PlatformDeviceId.getDeviceId;
    return result!;
  }
}
