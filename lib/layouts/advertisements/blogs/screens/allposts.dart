// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/screens/blog_screen.dart';

class AllPosts extends StatefulWidget {
  const AllPosts({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  State<AllPosts> createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('connection problem...'),
          duration: Duration(milliseconds: 1500),
          width: 280.0,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  saveImages(Uint8List blogimage, doc_idd) async {
    blog_images = Hive.box<Uint8List>("blogimages");
    blog_images!.put("$doc_idd", blogimage);
    print("image $doc_idd added");
  }

  late Stream<QuerySnapshot<Map<String, dynamic>>> allblogs;
  CollectionReference blogs = FirebaseFirestore.instance.collection('blogg');
  @override
  void initState() {
    blog_images = Hive.box<Uint8List>("blogimages");
    _AnimatedFlutterLogoState();
    if (widget.title.toString().contains("Popular")) {
      allblogs = FirebaseFirestore.instance
          .collection('blogg')
          .orderBy("viewers", descending: true)
          .snapshots();
    } else {
      allblogs = FirebaseFirestore.instance
          .collection('blogg')
          .orderBy("created", descending: true)
          .limit(10)
          .snapshots();
    }
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  List<String> blogurll = [];
  List<String> doc_ids = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> docsss = [];
  @override
  Widget build(BuildContext context) {
    Color appbar = appColr;
    Color log_txt = Colors.black87;
    Color log_page = Colors.white;
    final ThemeData mode = Theme.of(context);
    var whichMode = mode.brightness;
    if (whichMode == Brightness.dark) {
      setState(() {
        log_page = Colors.black26;
        appbar = Colors.black12;
        log_txt = Colors.white;
      });
    }
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          backgroundColor: appbar,
          title: new Text(widget.title),
          actions: [
            IconButton(
              onPressed: () async {
                if (docsss.isNotEmpty) {
                  showSearch(
                    context: context,
                    // delegate to customize the search bar
                    delegate: CustomSearchDelegate(
                        blogss: docsss, log_page: log_page, log_text: log_txt),
                  );
                } else {
                  print("docs is empty......");
                }
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: StreamBuilder(
            stream: allblogs,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
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
                            .map((blog) => GestureDetector(
                                  onTap: () {
                                    catchViewer(blog['doc_id']);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => BlogScreen(
                                                  blog: blog,
                                                  backgrnd: log_page,
                                                  b_white: log_txt,
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
                                      color: log_page,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 20.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.22,
                                            height: 110,
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: blog_images != null
                                                    ? blog_images!.get(
                                                                "${blog['doc_id']}") !=
                                                            null
                                                        ? Image.memory(
                                                            blog_images!.get(
                                                                "${blog['doc_id']}")!,
                                                            fit: BoxFit.cover)
                                                        : Center(
                                                            child:
                                                                 CircularProgressIndicator(color: appColr,strokeWidth: 3.0,))
                                                    : Center(
                                                        child:
                                                             CircularProgressIndicator(color: appColr,strokeWidth: 3.0,))),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
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
                                                                    ? (Duration(days: DateTime.parse(DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 7).floor() >=
                                                                            4
                                                                        ? (Duration(days: DateTime.parse(DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 7).floor() >=
                                                                                48
                                                                            ? Text(
                                                                                "${(Duration(days: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 336).floor()} yrs ago",
                                                                                style: TextStyle(
                                                                                  color: Colors.grey,
                                                                                ),
                                                                              )
                                                                            : Text(
                                                                                "${(Duration(days: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 28).floor()} months ago",
                                                                                style: TextStyle(
                                                                                  color: Colors.grey,
                                                                                ),
                                                                              )
                                                                        : Text(
                                                                            "${(Duration(days: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 7).floor()} weeks ago",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.grey,
                                                                            ),
                                                                          )
                                                                    : Text(
                                                                        "${Duration(days: DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays % 7} days ago",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
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
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
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
                  ]),
                );
              } else {
                Center(child: Text("No data is available"));
              }
              return Center(child:  CircularProgressIndicator(color: appColr,strokeWidth: 3.0,));
            }));
  }

  void catchViewer(blog) async {
    final firebase =
        FirebaseFirestore.instance.collection("blogg").doc("$blog");
    DocumentReference ref =
        FirebaseFirestore.instance.collection("blogg").doc("$blog");
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

//searching
class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  List<QueryDocumentSnapshot<Map<String, dynamic>>> blogss;
  Color log_page;
  Color log_text;
  CustomSearchDelegate({
    required this.blogss,
    required this.log_page,
    required this.log_text,
  });

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          for (var x in blogss) {
            print("imefikaa...................${x['title']}");
          }

          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_ios_new),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    List<QueryDocumentSnapshot<Map<String, dynamic>>> blogggs = [];
    for (var fruit in blogss) {
      print(fruit["title"]);
      if (fruit['title'].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit['title']);
        blogggs.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          onTap: () {
            catchViewer(blogss[index]['doc_id']);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlogScreen(
                          blog: blogggs[index],
                          backgrnd: log_page,
                          b_white: log_text,
                        )));
          },
          leading: CircleAvatar(
              backgroundColor: appColr,
              child: Text(result.toString().substring(4, 6))),
          title: Text(result),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
          ),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery2 = [];
    List<QueryDocumentSnapshot<Map<String, dynamic>>> blogggs = [];
    for (var fruit in blogss) {
      print(fruit["title"]);
      if (fruit['title'].toLowerCase().contains(query.toLowerCase())) {
        matchQuery2.add(fruit['title']);
        blogggs.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery2.length,
      itemBuilder: (context, index) {
        var result = matchQuery2[index];

        return ListTile(
          onTap: () {
            catchViewer(blogss[index]['doc_id']);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlogScreen(
                          blog: blogggs[index],
                          backgrnd: log_page,
                          b_white: log_text,
                        )));
          },
          leading: CircleAvatar(
              backgroundColor: appColr,
              child: Text(result.toString().substring(2, 4))),
          title: Text(result),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
          ),
        );
      },
    );
  }

  void catchViewer(blog) async {
    final firebase =
        FirebaseFirestore.instance.collection("blogg").doc("$blog");
    DocumentReference ref =
        FirebaseFirestore.instance.collection("blogg").doc("$blog");
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
