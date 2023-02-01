import 'dart:io';

import 'package:checkmark/checkmark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/advertisements/animated/dialogbox.dart';
// Import the plugin
import '../modal/blog.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({super.key});

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  TextEditingController e_title = TextEditingController();
  TextEditingController e_body = TextEditingController();
  TextEditingController e_author = TextEditingController();
  TextEditingController e_date = TextEditingController();
  TextEditingController e_venue = TextEditingController();
  bool active = false;
  Stream<List<Blog>> readUsers() => FirebaseFirestore.instance
      .collection("blogs")
      .snapshots()
      .map((event) => event.docs.map((e) => Blog.fromMap(e.data())).toList());
  CollectionReference blogs = FirebaseFirestore.instance.collection('blogs');
  late String uid;
  var doc_idd;
  Box<List<String>>? deleted;
  @override
  void initState() {
    deleted = Hive.box<List<String>>("del_docs");
    uid = FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }

  List<String> options = ["delete", "update"];
  String? user_phot;
  String? blog_phot;
  bool attempt = false;
  Stream<QuerySnapshot<Map<String, dynamic>>>? myblogs;
  @override
  Widget build(BuildContext context) {
    setState(() {
      myblogs = FirebaseFirestore.instance
          .collection('blogs')
          .where("uid", isEqualTo: uid)
          .snapshots();
    });

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
          actions: [],
        ),
        body: StreamBuilder(
          stream: myblogs,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData) {
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
                                          child: Image.network(
                                            '${blog['blog']}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
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
                                      ),
                                      //
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
                                                          ? const CircularProgressIndicator()
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
                                      )
                                    ],
                                  ),
                                ),
                              ))
                          .toList()),
                ]),
              );
            }
            return Center(child: const CircularProgressIndicator());
          },
        ));
  }

  List<String> actions = ["delete", "update"];

  void deleteBlog(blog) async {
    try {
      setState(() {
        print("apaaaaa................");
        List<String> docs = [];
        if (deleted!.get('docs') == null) {
          print("apaaaaa null................");
          docs.add(blog.toString());
          deleted!.put("docs", docs);
        } else {
          print("apaaaaa co null................");
          List<String>? docss = deleted!.get('docs');
          docs.add(blog.toString());
          for (var d = 0; d < docss!.length; d++) {
            print(docss[d].toString() + " added");
            docs.add(docss[d].toString());
          }
          print("mwish................");
          deleted!.put("docs", docs);
          setState(() {
            deleted!.get('docs');
          });
        }
        active = true;
      });
      CollectionReference blogs =
          FirebaseFirestore.instance.collection('blogs');

      print(blog);
      blogs.doc(blog.toString()).delete();
      //delete photos
      storage.Reference blogref =
          storage.FirebaseStorage.instance.ref().child("blogs").child("/$blog");
      storage.Reference userref =
          storage.FirebaseStorage.instance.ref().child("users").child("/$blog");
      blogref.delete();
      userref.delete();
      setState(() {
        myblogs = FirebaseFirestore.instance
            .collection('blogs')
            .where("uid", isEqualTo: uid)
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

  updateBlog() async {
    try {
      DateTime now = DateTime.now();
      var created = DateFormat("yyyy-MM-dd hh:mm:ss").format(now);
      final firebase =
          FirebaseFirestore.instance.collection("blogs").doc("$doc_idd");
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
        'uid': uid,
        'author_name': e_author.text,
        "title": e_title.text,
        "body": e_body.text,
        "date": e_date.text,
        "venue": e_venue.text,
        "blog": u_blog_image != null ? blogurl : blog_phot,
        "user": u_user_image != null ? userurl : user_phot,
        "created": created
      };
      print("apaaa.3..");
      firebase.set(json);
      Navigator.of(context).pop();
      setState(() {
        myblogs = FirebaseFirestore.instance
            .collection('blogs')
            .where("uid", isEqualTo: uid)
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
