// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import "package:http/http.dart" as http;

import 'package:udom_timetable/layouts/admin/Posts/postcard.dart';

import '../../Screens/Colors/colors.dart';

class PostsManage extends StatefulWidget {
  const PostsManage({
    Key? key,
    required this.username,
    required this.uid,
  }) : super(key: key);
  final String username;
  final String uid;
  @override
  State<PostsManage> createState() => _PostsManageState();
}

class _PostsManageState extends State<PostsManage> {
  List<String> options = ["hide", "update"];
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

  List<QueryDocumentSnapshot<Map<String, dynamic>>> docsss = [];
  Stream<QuerySnapshot<Map<String, dynamic>>>? myblogs;
  Box<List<String>>? deleted;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> container = [];
  int actives = 0;
  int hidens = 0;
  checkHiddens() {
    setState(() {
      FirebaseFirestore.instance
          .collection('blogg')
          .where("hide", isEqualTo: true)
          .where("uid", isEqualTo: widget.uid)
          .get()
          .then((value) {
        hidens = value.docs.length;
        print("hidden $hidens");
        print("total ${docsss.length}");
        actives = docsss.length - hidens;
      });
    });
  }

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
      checkHiddens();
    });
    blog_images = Hive.box<Uint8List>("blogimages");
    deleted = Hive.box<List<String>>("del_docs");
    super.initState();
  }

  Future setSwitchOnn(bool isSwitchedd, String id) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection("blogg").doc("$id");
    final data = {"hide": isSwitchedd};
    ref.update(data);
  }

  void toggleSwitchh(bool value, String id) {
    if (value == false) {
      setState(() {
        setSwitchOnn(true, id);
      });
    } else {
      setState(() {
        setSwitchOnn(false, id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color log_txt = Colors.black87;
    Color appbar = appColr;
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
        backgroundColor: appbar,
        centerTitle: true,
        title: Text("User Posts"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
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
      body: Column(
        children: [
          PostCard(
              total: "${docsss.length}",
              hidden: "$hidens",
              active: "$actives",
              username: "${widget.username}"),
          Expanded(
              child: StreamBuilder(
            stream: myblogs,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  setState(() {
                    docsss = snapshot.data!.docs;
                  });
                  checkHiddens();
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.54,
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
                                                                  ? (Duration(days: DateTime.parse(DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now())).difference(DateTime.parse(blog['created'].toString())).inDays).inDays / 7)
                                                                              .floor() >=
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
                                        Switch(
                                          onChanged: (value) {
                                            toggleSwitchh(blog['hide'],
                                                blog['doc_id'].toString());
                                          },
                                          value: blog['hide'],
                                          activeColor: Colors.blue,
                                          activeTrackColor: Colors.yellow,
                                          inactiveThumbColor: Colors.redAccent,
                                          inactiveTrackColor: Colors.orange,
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList()),
                  ]),
                );
              }
              return CircularProgressIndicator(
                color: appColr,
                strokeWidth: 3.0,
              );
            },
          ))
        ],
      ),
    );
  }
}

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
  Future setSwitchOnn(bool isSwitchedd, String id) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection("blogg").doc("$id");
    
    final data = {"hide": isSwitchedd};
    ref.update(data);
  }

  void toggleSwitchh(bool value, String id) {
    if (value == false) {
        setSwitchOnn(true, id);
    
    } else {

        setSwitchOnn(false, id);
    }
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
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => BlogScreen(
              //               blog: blogggs[index],
              //               backgrnd: log_page,
              //               b_white: log_text,
              //             )));
            },
            leading: CircleAvatar(
                backgroundColor: appColr,
                child: Text(result.toString().substring(4, 6))),
            title: Text(result),
            trailing: Text(''));
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery2 = [];
    List<bool> hiden = [];
     List<String> ids = [];
    List<QueryDocumentSnapshot<Map<String, dynamic>>> blogggs = [];
    for (var fruit in blogss) {
      print(fruit["title"]);
      if (fruit['title'].toLowerCase().contains(query.toLowerCase())) {
        matchQuery2.add(fruit['title']);
        blogggs.add(fruit);
        hiden.add(fruit["hide"]);
        ids.add(fruit["doc_id"].toString());
       
      }
      
    }
    return ListView.builder(
      itemCount: matchQuery2.length,
      itemBuilder: (context, index) {
        var result = matchQuery2[index];

        return ListTile(
          onTap: () {
                    print("my fruits $hiden");

        toggleSwitchh(hiden[matchQuery2.length-index],
                  ids[index].toString());
          },
          leading: CircleAvatar(
              backgroundColor: appColr,
              child: Text(result.toString().substring(2, 4))),
          title: Text(result),
          trailing: Switch(
            onChanged: (value) {
          
            },
            value: hiden[index],
            activeColor: Colors.blue,
            activeTrackColor: Colors.yellow,
            inactiveThumbColor: Colors.redAccent,
            inactiveTrackColor: Colors.orange,
          ),
        );
      },
    );
  }
}
