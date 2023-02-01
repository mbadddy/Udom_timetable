// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/screens/blog_screen.dart';

class RecentPosts extends StatelessWidget {
  Color backgrnd;
  Color b_white;
  Stream<QuerySnapshot<Map<String, dynamic>>> myblogs;
  RecentPosts({
    Key? key,
    required this.backgrnd,
    required this.b_white,
    required this.myblogs,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: myblogs,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.hasData) {
            print("has data........");
            return Container(
              color: backgrnd,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: snapshot.data!.docs
                      .map((blog) => GestureDetector(
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
                            child: Container(
                              margin: EdgeInsets.only(bottom: 15.0),
                              width: MediaQuery.of(context).size.width,
                              height: 140,
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 15.0,
                                      offset: Offset(0.0, 0.75))
                                ],
                                color: backgrnd,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.22,
                                      height: 110,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image(
                                          image: NetworkImage(blog['blog']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.66,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(height: 5.0),
                                          Text(
                                            blog['author_name'],
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Container(
                                            height: 65,
                                            child: Text(
                                              blog['title'],
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: b_white,
                                                  fontWeight: FontWeight.bold),
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
                                                  Duration(
                                                                  minutes: DateTime.parse(DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()))
                                                                      .difference(DateTime.parse(
                                                                          blog['created']
                                                                              .toString()))
                                                                      .inMinutes)
                                                              .inMinutes >=
                                                          60
                                                      ? Duration(hours: DateTime.parse(DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inHours)
                                                                  .inHours >=
                                                              24
                                                          ? Duration(days: DateTime.parse(DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays)
                                                                      .inDays >=
                                                                  7
                                                              ? (Duration(days: DateTime.parse(DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays /
                                                                              7)
                                                                          .floor() >=
                                                                      4
                                                                  ? (Duration(days: DateTime.parse(DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 7)
                                                                              .floor() >=
                                                                          48
                                                                      ? Text(
                                                                          "${(Duration(days: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 336).floor()} yrs ago",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        )
                                                                      : Text(
                                                                          "${(Duration(days: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 28).floor()} months ago",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        )
                                                                  : Text(
                                                                      "${(Duration(days: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 7).floor()} weeks ago",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    )
                                                              : Text(
                                                                  "${Duration(days: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays % 7} days ago",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                )
                                                          : Text(
                                                              "${Duration(hours: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inHours).inHours} hrs ago",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
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
                                                    "${blog['viewers']} Views",
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
                            ),
                          ))
                      .toList()),
            );
          } else {
            Center(child: Text("No data is available"));
          }
          return Center(child: const CircularProgressIndicator());
        });
  }

  void catchViewer(blog) async {
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
    final data={
      "viewers":int.parse("$viewers")+1
    };
    String dev_id=await getDeviceInfo();
      Box<List<String>>? deleteed=Hive.box<List<String>>("del_docs");
      List<String>? device_views=[];
      List<String>? views=deleteed.get("$dev_id");
      print("device id $dev_id");
      if(views!=null){
         if (!views.contains(doc_id.toString())) {
              for(var x=0;x<views.length;x++){
                device_views.add(views[x]);
            }
          device_views.add(doc_id.toString());
          deleteed.put("$dev_id", device_views);
          ref.update(data);
            print("device $dev_id doc $doc_id views ${int.parse("$viewers")+1}");
            print("all views ${deleteed.get("$dev_id")}");
        }
        else{
            if(views.isEmpty){
              device_views.add(doc_id);
             deleteed.put("$dev_id", device_views);
             ref.update(data);
             print("device $dev_id doc $doc_id views ${int.parse("$viewers")+1}");
            }
        }
      }
      else{
             device_views.add(doc_id);
             deleteed.put("$dev_id", device_views);
             ref.update(data);
            print("device $dev_id doc $doc_id views ${int.parse("$viewers")+1}");
      }
       
  }
  
  Future<String> getDeviceInfo()async {
    String? result=await  PlatformDeviceId.getDeviceId;
    return result!;
  }
}
