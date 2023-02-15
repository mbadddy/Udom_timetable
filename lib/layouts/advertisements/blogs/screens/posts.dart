// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import "package:http/http.dart" as http;
import 'package:checkmark/checkmark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:platform_device_id/platform_device_id.dart';

import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/advertisements/animated/dialogbox.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final String uid;
  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  Box<Uint8List>? blog_images;
  late Timer _timer;
  _AnimatedFlutterLogoState() {
    _timer = new Timer(const Duration(seconds: 5), () {
      setState(() {
        LoadAndAddDta();
      });
    });
  }

  LoadAndAddDta() {
    if (docsss.isNotEmpty) {
      if (docsss.isNotEmpty) {
        if (blog_images == null) {
          for (var blg in docsss) {
            _fileFromImageUrl(blg["blog"], blg["doc_id"]);
          }
        } else {
          for (var blg in docsss) {
            if (blog_images!.get(blg['doc_id']) == null) {
              _fileFromImageUrl(blg["blog"], blg["doc_id"]);
            }
          }
        }
      }
    }
  }

  Future<void> _fileFromImageUrl(blogurl, doc_id) async {
    try {
      final blogresponse = await http.get(Uri.parse('$blogurl'));
      saveImages(blogresponse.bodyBytes, doc_id);
    } catch (e) {
      print("error conection......");
    }
  }

  saveImages(Uint8List blogimage, doc_idd) async {
    blog_images = Hive.box<Uint8List>("blogimages");
    blog_images!.put("$doc_idd", blogimage);
    print("image $doc_idd added");
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? myblogs;
  @override
  void initState() {
    _AnimatedFlutterLogoState();
    super.initState();
    setState(() {
      myblogs = FirebaseFirestore.instance
          .collection('blogg')
          .orderBy("doc_id", descending: false)
          .where("uid", isEqualTo: widget.uid)
          .snapshots();
    });
    blog_images = Hive.box<Uint8List>("blogimages");
    deleted = Hive.box<List<String>>("del_docs");
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> docsss = [];
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  TextEditingController e_title = TextEditingController();
  TextEditingController e_body = TextEditingController();
  TextEditingController e_author = TextEditingController();
  TextEditingController e_date = TextEditingController();
  TextEditingController e_venue = TextEditingController();
  bool active = false;

  CollectionReference blogs = FirebaseFirestore.instance.collection('blogg');

  var doc_idd;
  Box<List<String>>? deleted;
  List<String> options = ["delete", "update"];
  List<String> categorys = ["sort", "delete all"];
  String? user_phot;
  String? blog_phot;
  bool attempt = false;
  List<String> sort = ["Viewers", "Time", "Title", "Author", "Event date"];

  @override
  Widget build(BuildContext context) {
    Color appbar = appColr;
    Color log_page = Colors.white;
    Color log_txt = Colors.black87;
    final ThemeData mode = Theme.of(context);
    var whichMode = mode.brightness;
    if (whichMode == Brightness.dark) {
      setState(() {
        appbar = Colors.black12;
        log_page = Colors.black26;
        log_txt = Colors.white;
      });
    }
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new)),
          title: new Text("My Posts"),
          backgroundColor: appbar,
          actions: [
            PopupMenuButton(
              position: PopupMenuPosition.under,
              onSelected: (value) async {
                if (value == 'delete all') {
                  print("delete all.............");
                  await animated_dialog_box.showInOutDailog(
                    context: context,
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.red,
                    ),
                    firstButton: MaterialButton(
                      // FIRST BUTTON IS REQUIRED
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      color: Colors.white,
                      child: Text("cancel"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    secondButton: MaterialButton(
                      // OPTIONAL BUTTON
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      color: Colors.white,
                      child: Text('yes'),
                      onPressed: () {
                        deleteBlog(0);
                        Navigator.of(context).pop();
                      },
                    ),
                    yourWidget: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                              "Are you sure you want to clear all of your blog posts.."),
                        )
                      ],
                    ),
                  );
                }
              },
              itemBuilder: (context) => categorys.map((String option) {
                bool isempty = false;
                myblogs!.listen((event) {
                  if (event.docs.isEmpty) {
                    isempty = true;
                  }
                });
                if (!isempty) {}
                if (option == "sort") {
                  return PopupMenuItem<String>(
                    value: option,
                    child: PopupMenuButton(
                      position: PopupMenuPosition.under,
                      child: Row(
                        children: [
                          Text('Sort By '),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: appColr,
                          )
                        ],
                      ),
                      onSelected: (result) {
                        // setState(() { _selection = result; });
                        if (result == "Viewers") {
                          setState(() {
                            myblogs = FirebaseFirestore.instance
                                .collection('blogg')
                                .orderBy("uid")
                                .where("uid", isEqualTo: widget.uid)
                                .orderBy("viewers", descending: true)
                                .snapshots();
                          });
                        } else if (result == "Time") {
                          setState(() {
                            myblogs = FirebaseFirestore.instance
                                .collection('blogg')
                                .where("uid", isEqualTo: widget.uid)
                                .orderBy("created", descending: true)
                                .snapshots();
                          });
                        } else if (result == "Title") {
                          setState(() {
                            myblogs = FirebaseFirestore.instance
                                .collection('blogg')
                                .where("uid", isEqualTo: widget.uid)
                                .orderBy("title", descending: false)
                                .snapshots();
                          });
                        } else if (result == "Author") {
                          setState(() {
                            myblogs = FirebaseFirestore.instance
                                .collection('blogg')
                                .where("uid", isEqualTo: widget.uid)
                                .orderBy("author_name", descending: false)
                                .snapshots();
                          });
                        } else {
                          setState(() {
                            myblogs = FirebaseFirestore.instance
                                .collection('blogg')
                                .where("uid", isEqualTo: widget.uid)
                                .orderBy("date", descending: false)
                                .snapshots();
                          });
                        }
                        Navigator.pop(context);
                      },
                      itemBuilder: (context) => sort.map((String e) {
                        return PopupMenuItem(
                          child: Text(e),
                          value: e,
                        );
                      }).toList(),
                    ),
                  );
                } else {
                  return PopupMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }
              }).toList(),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: myblogs,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }

            if (snapshot.hasData) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                  docsss = snapshot.data!.docs;
                });
              });
              return Container(
                color: log_page,
                child: ListView(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: snapshot.data!.docs
                          .map((blog) => Container(
                                margin: EdgeInsets.only(bottom: 15.0),
                                width: MediaQuery.of(context).size.width,
                                height: 150,
                                decoration: BoxDecoration(
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 15.0,
                                        offset: Offset(0.0, 0.75))
                                  ],
                                  color: log_page,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.22,
                                        height: 110,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: blog_images != null
                                                ? blog_images!.get(
                                                            "${blog['doc_id']}") !=
                                                        null
                                                    ? Image.memory(
                                                        filterQuality: FilterQuality.high,
                                                        blog_images!.get(
                                                            "${blog['doc_id']}")!,
                                                        fit: BoxFit.cover)
                                                    : Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                        color: Colors.white,
                                                        strokeWidth: 3.0,
                                                      ))
                                                : Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 3.0,
                                                  ))),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.59,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
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
                                              height: 55,
                                              child: Text(
                                                blog['title'],
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: log_txt,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                                        .difference(DateTime.parse(blog['created']
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
                                                                    ? (Duration(days: DateTime.parse(DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 7).floor() >=
                                                                            48
                                                                        ? Text(
                                                                            "${(Duration(days: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 336).floor()} yrs ago",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.grey,
                                                                            ),
                                                                          )
                                                                        : Text(
                                                                            "${(Duration(days: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 28).floor()} months ago",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.grey,
                                                                            ),
                                                                          )
                                                                    : Text(
                                                                        "${(Duration(days: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 7).floor()} weeks ago",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
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
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              )
                                                        : Text(
                                                            "${Duration(minutes: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inMinutes).inMinutes} min ago",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
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
                                      ),
                                      //
                                      Column(
                                        children: [
                                          Padding(padding: EdgeInsets.all(10),
                                          child:blog['hide']? Icon(Icons.hide_source,color: Colors.red,)
                                          :Icon(Icons.check,color: Colors.green,)
                                          ),
                                          PopupMenuButton(
                                            position: PopupMenuPosition.under,
                                            onSelected: (value) async {
                                              if (value == "delete") {
                                                await animated_dialog_box
                                                    .showInOutDailog(
                                                        title: Center(
                                                            child: Text(
                                                                "Hello")), // IF YOU WANT TO ADD
                                                        context: context,
                                                        firstButton: MaterialButton(
                                                          // FIRST BUTTON IS REQUIRED
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(40),
                                                          ),
                                                          color: Colors.white,
                                                          child: Text("cancel"),
                                                          onPressed: () {
                                                            Navigator.of(context)
                                                                .pop();
                                                          },
                                                        ),
                                                        secondButton:
                                                            MaterialButton(
                                                          // OPTIONAL BUTTON
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(40),
                                                          ),
                                                          color: Colors.white,
                                                          child: active == true
                                                              ? CircularProgressIndicator()
                                                              : Text(value),
                                                          onPressed: () async {
                                                            setState(() {
                                                              active = true;
                                                            });

                                                            deleteBlog(
                                                                blog['doc_id']);
                                                          },
                                                        ),
                                                        icon: Icon(
                                                          Icons.info_outline,
                                                          color: Colors.red,
                                                        ), // IF YOU WANT TO ADD ICON
                                                        yourWidget: Container(
                                                          child: Text(
                                                              'Are you sure !! you want to delete this post ??'),
                                                        ));
                                              } else if (value == "update") {
                                                setState(() {
                                                  e_title.text = blog["title"];
                                                  e_body.text = blog["body"];
                                                  e_author.text =
                                                      blog["author_name"];
                                                  e_date.text = blog["date"];
                                                  e_venue.text = blog["venue"];
                                                  blog_phot = blog["blog"];
                                                  user_phot = blog["user"];
                                                  doc_idd = blog["doc_id"];
                                                  viewers = blog["viewers"];
                                                });
                                                await animated_dialog_box
                                                    .showScaleUpdateAlertBox(
                                                        context: context,
                                                        firstButton: MaterialButton(
                                                          // FIRST BUTTON IS REQUIRED
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(40),
                                                          ),
                                                          color: Colors.white,
                                                          child: Text('cancel'),
                                                          onPressed: () {
                                                            Navigator.of(context)
                                                                .pop();
                                                          },
                                                        ),
                                                        secondButton:
                                                            MaterialButton(
                                                          // OPTIONAL BUTTON
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(40),
                                                          ),
                                                          color: Colors.white,
                                                          child: Text("next"),
                                                          onPressed: () async {
                                                            e_title.text =
                                                                e_title.text;
                                                            e_body.text =
                                                                e_body.text;
                                                            e_author.text =
                                                                e_author.text;
                                                            e_date.text =
                                                                e_date.text;
                                                            Navigator.of(context)
                                                                .pop();
                                                            //
                                                            editNextContext(
                                                                blog["venue"],
                                                                blog["blog"],
                                                                blog["user"]);
                                                            //
                                                          },
                                                        ),
                                                        // IF YOU WANT TO ADD ICON
                                                        yourWidget: editWidget(
                                                            blog['title'],
                                                            blog['body'],
                                                            blog['author_name'],
                                                            blog['date'],
                                                            blog['venue']));
                                              }
                                              //
                                            },
                                            itemBuilder: (context) =>
                                                options.map((String option) {
                                              return PopupMenuItem<String>(
                                                value: option,
                                                child: Text(option),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ))
                          .toList()),
                ]),
              );
            }
            return Center(
                child: CircularProgressIndicator(
              color: appColr,
              strokeWidth: 3.0,
            ));
          },
        ));
  }

  Future<String> getDeviceInfo() async {
    String? result = await PlatformDeviceId.getDeviceId;
    return result!;
  }

  List<String> actions = ["delete", "update"];

  void deleteBlog(blog) async {
    String dev_id = await getDeviceInfo();
    Box<List<String>>? deleteed = Hive.box<List<String>>("del_docs");
    if (blog == 0) {
      try {
        List<String>? device_views = [];
        List<String>? views = deleteed.get("$dev_id");
        if (views != null) {
          deleteed.put("$dev_id", device_views);
        }
        print("deleting......");
        setState(() {
          active = true;
        });

        setState(() async {
          // CollectionReference blogs =
          //     FirebaseFirestore.instance.collection('blog');
          CollectionReference reff =
              FirebaseFirestore.instance.collection("blogg");
          reff.get().then((value) async {
            List<Map<dynamic, dynamic>>? list = [];
            list = value.docs.map((doc) => doc.data()).cast<Map>().toList();
            for (var doc in list) {
              reff.doc(doc["doc_id"].toString()).delete();
              print("deleting blogs......${doc["doc_id"]}");
            }
          });

          // blogs.snapshots().forEach((element) {
          //   for (QueryDocumentSnapshot snapshot in element.docs) {
          //     snapshot.reference.delete();
          //     print("deleting blogs......");
          //   }
          // });
          //delete photos
          storage.ListResult userref = await storage.FirebaseStorage.instance
              .ref()
              .child("users")
              .listAll();

          storage.ListResult blogref = await storage.FirebaseStorage.instance
              .ref()
              .child("blogs")
              .listAll();
          for (storage.Reference reff in blogref.items) {
            print("deleting blog imgs......");
            reff.delete();
          }
          for (storage.Reference reff2 in userref.items) {
            print("deleting user imgs......");
            reff2.delete();
          }

          blog_images!.deleteAll(blog_images!.keys);
          print("deleting local imgs......");
          // blog_images = Hive.box<Uint8List>("blogimages");
        });
        print("deleting complete imgs......");
        Navigator.of(context).pop();
        await animated_dialog_box.showCustomAlertBox(
          context: context,
          firstButton: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            color: Colors.white,
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          yourWidget: Column(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CheckMark(
                  active: true,
                  curve: Curves.decelerate,
                  duration: const Duration(milliseconds: 5000),
                ),
              ),
              Text("deleted..")
            ],
          ),
        );
        setState(() {
          myblogs = FirebaseFirestore.instance
              .collection('blogg')
              .where("uid", isEqualTo: widget.uid)
              .snapshots();
          active = false;
        });
      } catch (e) {
        setState(() {
          active = false;
        });

        Navigator.of(context).pop();
        await animated_dialog_box.showCustomAlertBox(
          context: context,
          firstButton: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            color: Colors.white,
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          yourWidget: Column(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CheckMark(
                  active: false,
                  curve: Curves.decelerate,
                  duration: const Duration(milliseconds: 5000),
                ),
              ),
              Text("error!!..")
            ],
          ),
        );
      }
    } else {
      try {
        List<String>? device_views = [];
        List<String>? views = deleteed.get("$dev_id");
        if (views != null) {
          for (var x = 0; x < views.length; x++) {
            if(views[x]!=blog.toString()){
                device_views.add(views[x].toString());
            }
            else{
             print("${views[x]} removed...........");
            }
            
          }
          deleteed.put("$dev_id", device_views);
        }

        setState(() {
          active = true;
        });

        setState(() {
          CollectionReference blogs =
              FirebaseFirestore.instance.collection('blogg');

          blogs.doc(blog.toString()).delete();
          //delete photos
          storage.Reference blogref = storage.FirebaseStorage.instance
              .ref()
              .child("blogs")
              .child("/$blog");
          storage.Reference userref = storage.FirebaseStorage.instance
              .ref()
              .child("users")
              .child("/$blog");
          blogref.delete();
          userref.delete();
          blog_images!.delete("$blog");
          blog_images = Hive.box<Uint8List>("blogimages");
          myblogs = FirebaseFirestore.instance
              .collection('blogg')
              .where("uid", isEqualTo: widget.uid)
              .snapshots();
        });
        setState(() {
          active = false;
        });
        Navigator.of(context).pop();
        await animated_dialog_box.showCustomAlertBox(
          context: context,
          firstButton: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            color: Colors.white,
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          yourWidget: Column(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CheckMark(
                  active: true,
                  curve: Curves.decelerate,
                  duration: const Duration(milliseconds: 5000),
                ),
              ),
              Text("deleted..")
            ],
          ),
        );
      } catch (e) {
        setState(() {
          active = false;
        });
        Navigator.of(context).pop();
        await animated_dialog_box.showCustomAlertBox(
          context: context,
          firstButton: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            color: Colors.white,
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          yourWidget: Column(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CheckMark(
                  active: false,
                  curve: Curves.decelerate,
                  duration: const Duration(milliseconds: 5000),
                ),
              ),
              Text("error!!..")
            ],
          ),
        );
      }
    }
  }

  var u_user_image;
  var u_blog_image;
  //methods
  final ImagePicker picker = ImagePicker();
  Future _pickAuthorCamera() async {
    XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: double.infinity,
        imageQuality: 50);
    setState(() {
      u_user_image = File(photo!.path);
    });
  }

  Future _pickBlogCamera() async {
    XFile? photo = await picker.pickImage(
        source: ImageSource.camera, maxWidth: 400, imageQuality: 50);
    setState(() {
      u_blog_image = File(photo!.path);
    });
  }

  Future _pickAuthorgallary() async {
    XFile? photo = await picker.pickImage(
        source: ImageSource.gallery, maxWidth: 400, imageQuality: 50);
    setState(() {
      u_user_image = File(photo!.path);
    });
  }

  Future _pickBlogGallary() async {
    XFile? photo = await picker.pickImage(
        source: ImageSource.gallery, maxWidth: 400, imageQuality: 50);
    setState(() {
      u_blog_image = File(photo!.path);
    });
  }

  //end
  Widget nextEdit(venue, blog_photo, user_photo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 2),
          child: TextField(
            controller: e_venue,
            style: TextStyle(color: Colors.black, fontSize: 13.5),
            decoration: InputDecoration(
                prefixIconConstraints: BoxConstraints(minWidth: 20),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black12,
                  size: 15,
                ),
                labelText: 'edit venue',
                hintStyle: TextStyle(color: Colors.black, fontSize: 14.5),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100)
                        .copyWith(bottomRight: Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.black26)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100)
                        .copyWith(bottomRight: Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.black26))),
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      width: 135,
                      child: u_user_image == null
                          ? Center(
                              child: Text(
                              "user image",
                              style: TextStyle(color: Colors.white),
                            ))
                          : Image.file(
                              u_user_image,
                              fit: BoxFit.cover,
                            ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("$user_photo")),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                _pickAuthorgallary();
                                Navigator.of(context).pop();
                                setState(() {
                                  if (u_blog_image == null) {
                                    editNextContext(
                                        venue, blog_photo, u_user_image);
                                  } else {
                                    editNextContext(
                                        venue, u_blog_image, u_user_image);
                                  }
                                });
                              },
                              icon: Icon(Icons.file_present)),
                          SizedBox(
                            height: 5,
                          ),
                          IconButton(
                              onPressed: () {
                                _pickAuthorCamera();
                                Navigator.of(context).pop();
                                setState(() {
                                  if (u_blog_image == null) {
                                    editNextContext(
                                        venue, blog_photo, u_user_image);
                                  } else {
                                    editNextContext(
                                        venue, u_blog_image, u_user_image);
                                  }
                                });
                              },
                              icon: Icon(Icons.camera))
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      width: 135,
                      child: u_blog_image == null
                          ? Center(
                              child: Text(
                              "blog image",
                              style: TextStyle(color: Colors.white),
                            ))
                          : Image.file(
                              u_blog_image,
                              width: double.infinity,
                              height: 120.0,
                              fit: BoxFit.fitWidth,
                            ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("$blog_photo")),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                _pickBlogGallary();

                                if (u_user_image == null) {
                                  setState(() {
                                    editNextContext(
                                        venue, u_blog_image, user_photo);
                                  });
                                } else {
                                  setState(() {
                                    editNextContext(
                                        venue, u_blog_image, u_user_image);
                                  });
                                }
                              },
                              icon: Icon(Icons.file_present)),
                          SizedBox(
                            height: 5,
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                _pickBlogCamera();
                                if (u_user_image == null) {
                                  setState(() {
                                    editNextContext(
                                        venue, u_blog_image, user_photo);
                                  });
                                } else {
                                  setState(() {
                                    editNextContext(
                                        venue, u_blog_image, u_user_image);
                                  });
                                }
                              },
                              icon: Icon(Icons.camera))
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
      ],
    );
  }

  Widget editWidget(title, body, author_name, date, venue) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 5),
        child: TextField(
          controller: e_title,
          style: TextStyle(color: Colors.black, fontSize: 13.5),
          decoration: InputDecoration(
              prefixIconConstraints: BoxConstraints(minWidth: 20),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black12,
                size: 15,
              ),
              labelText: 'edit title',
              hintStyle: TextStyle(color: Colors.black, fontSize: 14.5),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100)
                      .copyWith(bottomRight: Radius.circular(0)),
                  borderSide: BorderSide(color: Colors.black26)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100)
                      .copyWith(bottomRight: Radius.circular(0)),
                  borderSide: BorderSide(color: Colors.black26))),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 5),
        child: TextField(
          maxLines: 6,
          controller: e_body,
          style: TextStyle(color: Colors.black, fontSize: 13.5),
          decoration: InputDecoration(
              prefixIconConstraints: BoxConstraints(minWidth: 20),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black12,
                size: 15,
              ),
              labelText: 'edit body',
              hintStyle: TextStyle(color: Colors.black, fontSize: 14.5),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100)
                      .copyWith(bottomRight: Radius.circular(0)),
                  borderSide: BorderSide(color: Colors.black26)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100)
                      .copyWith(bottomRight: Radius.circular(0)),
                  borderSide: BorderSide(color: Colors.black26))),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 5),
        child: TextField(
          controller: e_author,
          style: TextStyle(color: Colors.black, fontSize: 13.5),
          decoration: InputDecoration(
              prefixIconConstraints: BoxConstraints(minWidth: 20),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black12,
                size: 15,
              ),
              labelText: 'edit author',
              hintStyle: TextStyle(color: Colors.black, fontSize: 14.5),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100)
                      .copyWith(bottomRight: Radius.circular(0)),
                  borderSide: BorderSide(color: Colors.black26)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100)
                      .copyWith(bottomRight: Radius.circular(0)),
                  borderSide: BorderSide(color: Colors.black26))),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 5),
        child: TextField(
          controller: e_date,
          style: TextStyle(color: Colors.black, fontSize: 13.5),
          decoration: InputDecoration(
              prefixIconConstraints: BoxConstraints(minWidth: 20),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black12,
                size: 15,
              ),
              labelText: 'edit date',
              hintStyle: TextStyle(color: Colors.black, fontSize: 14.5),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100)
                      .copyWith(bottomRight: Radius.circular(0)),
                  borderSide: BorderSide(color: Colors.black26)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100)
                      .copyWith(bottomRight: Radius.circular(0)),
                  borderSide: BorderSide(color: Colors.black26))),
        ),
      ),
    ]);
  }

  editNextContext(venuee, blogg, userr) async {
    await animated_dialog_box.showScaleUpdateAlertBox(
        context: context,
        firstButton: MaterialButton(
          // FIRST BUTTON IS REQUIRED
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          color: Colors.white,
          child: Text('cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        secondButton: MaterialButton(
          // OPTIONAL BUTTON
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          color: Colors.white,
          child: attempt ? CircularProgressIndicator() : Text("save"),
          onPressed: () async {
            setState(() {
              attempt = true;
            });
            updateBlog();
          },
        ),
        // IF YOU WANT TO ADD ICON
        yourWidget: nextEdit(venuee, blogg, userr));
  }

  var viewers = 0;
  updateBlog() async {
    try {
      DateTime now = DateTime.now();
      var created = DateFormat("yyyy-MM-dd hh:mm:ss").format(now);
      final firebase =
          FirebaseFirestore.instance.collection("blogg").doc("$doc_idd");
      print("apaaa...");
      // print("${blog_photo}........................");
      storage.Reference ref = storage.FirebaseStorage.instance
          .ref()
          .child("blogs")
          .child("/$doc_idd");

      if (u_user_image != null) {
        print("apaaa.ee..");
        ref.putFile(File(u_user_image.path));
      }
      print("apaaa.1..");
      storage.Reference ref2 = storage.FirebaseStorage.instance
          .ref()
          .child("users")
          .child("/$doc_idd");
      if (u_blog_image != null) {
        ref2.putFile(File(u_blog_image.path));
      }
      print("apaaa.2..");
      String blogurl = await ref.getDownloadURL();
      String userurl = await ref2.getDownloadURL();
      final json = {
        'doc_id': doc_idd,
        'uid': widget.uid,
        'author_name': e_author.text,
        "title": e_title.text,
        "body": e_body.text,
        "date": e_date.text,
        "venue": e_venue.text,
        "blog": u_blog_image != null ? blogurl : blog_phot,
        "user": u_user_image != null ? userurl : user_phot,
        "created": created,
        "viewers": 0
      };
      print("apaaa.3..");
      firebase.set(json);
      Navigator.of(context).pop();
      setState(() {
        myblogs = FirebaseFirestore.instance
            .collection('blogg')
            .where("uid", isEqualTo: widget.uid)
            .snapshots();
      });

      print("apaaa.4..");
      setState(() {
        attempt = false;
      });
      await animated_dialog_box.showCustomAlertBox(
        context: context,
        firstButton: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          color: Colors.white,
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        yourWidget: Column(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: CheckMark(
                active: true,
                curve: Curves.decelerate,
                duration: const Duration(milliseconds: 400),
              ),
            ),
            Text("updated..")
          ],
        ),
      );
    } catch (e) {
      await animated_dialog_box.showCustomAlertBox(
        context: context,
        firstButton: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          color: Colors.white,
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        yourWidget: Column(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: CheckMark(
                active: false,
                curve: Curves.decelerate,
                duration: const Duration(milliseconds: 400),
              ),
            ),
            Text("error..")
          ],
        ),
      );
    }
  }
}
