// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';

import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/screens/posts.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/services/create_blog.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final String uid;
  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  Box<List<String>>? deleted;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String? date;
  final TextEditingController venueController = TextEditingController();
  var _author_photo;
  var _blog_photo;
  final ImagePicker picker = ImagePicker();
  List<String> options = ['my posts', "reference"];
  Future _pickAuthorCamera() async {
    XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: double.infinity,
        imageQuality: 50);
    setState(() {
      _author_photo = File(photo!.path);
    });
  }

  Future _pickBlogCamera() async {
    XFile? photo = await picker.pickImage(
        source: ImageSource.camera, maxWidth: 400, imageQuality: 50);
    setState(() {
      _blog_photo = File(photo!.path);
    });
  }

  Future _pickAuthorgallary() async {
    XFile? photo = await picker.pickImage(
        source: ImageSource.gallery, maxWidth: 400, imageQuality: 50);
    setState(() {
      _author_photo = File(photo!.path);
    });
  }

  Future _pickBlogGallary() async {
    XFile? photo = await picker.pickImage(
        source: ImageSource.gallery, maxWidth: 400, imageQuality: 50);
    setState(() {
      _blog_photo = File(photo!.path);
    });
  }

  List<String>? deletedd;
  @override
  void initState() {
    deleted = Hive.box<List<String>>("del_docs");
    // deleted!.deleteAll(deleted!.keys);
    super.initState();
  }

  var executed;
  @override
  Widget build(BuildContext context) {
    setState(() {
      deletedd = deleted!.get("docs");
    });
    Color appbar = appColr;
    Color appbar2 = appColr;
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
      appBar: AppBar(
        backgroundColor: appbar,
        centerTitle: true,
        title: Text('Create Post', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('connection problem while logging out'),
                      duration: Duration(milliseconds: 1500),
                      width: 280.0,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              icon: Icon(Icons.logout)),
          PopupMenuButton(
            position: PopupMenuPosition.under,
            onSelected: (value) {
              if (value == 'my posts') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyPosts(
                          uid: widget.uid,
                        )));
              }
            },
            itemBuilder: (context) => options.map((String option) {
              return PopupMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 80,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Author'),
                    Expanded(
                      child: TextField(
                        controller: authorController,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Profile Photo"),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: appbar,
                ),
                height: 250,
                width: double.infinity,
                child: _author_photo == null
                    ? Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                _pickAuthorCamera();
                              },
                              child: Icon(Icons.camera),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                _pickAuthorgallary();
                              },
                              child: Icon(Icons.photo_library),
                            ),
                          ],
                        ),
                      )
                    : Image.file(
                        _author_photo,
                        width: double.infinity,
                        height: 300.0,
                        fit: BoxFit.fitHeight,
                      ),
              ),
              Divider(),
              Container(
                height: 80,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Title'),
                    Expanded(
                      child: TextField(
                        controller: titleController,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Body'),
                    TextField(
                      controller: bodyController,
                      maxLines: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Event Date'),
                    Expanded(
                        child: DateTimePicker(
                      controller: dateController,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      dateLabelText: 'Date',
                      onChanged: (value) {
                        setState(() {
                          date = value;
                        });
                      },
                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val) => print(val),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 80,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Venue'),
                    Expanded(
                      child: TextField(
                        controller: venueController,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Feature Image'),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: appbar,
                      ),
                      height: 250,
                      width: double.infinity,
                      child: _blog_photo == null
                          ? Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FloatingActionButton(
                                    onPressed: () {
                                      _pickBlogCamera();
                                    },
                                    child: Icon(Icons.camera),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  FloatingActionButton(
                                    onPressed: () {
                                      _pickBlogGallary();
                                    },
                                    child: Icon(Icons.photo_library),
                                  ),
                                ],
                              ),
                            )
                          : Image.file(
                              _blog_photo,
                              width: double.infinity,
                              height: 300.0,
                              fit: BoxFit.fitHeight,
                            ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () async {
                          setState(() {
                            executed = false;
                          });
                          // CreateBlogg().create( titleController.text, bodyController.text,
                          //  venueController.text, date, _, blog_photo)

                          if (titleController.text.isNotEmpty &&
                              bodyController.text.isNotEmpty &&
                              date!.isNotEmpty &&
                              _author_photo != null &&
                              _blog_photo != null) {
                            DateTime now = DateTime.now();
                            DateTime input = DateTime.parse(date!);
                            Duration duration = input.difference(now);
                            print("${duration.inDays} hours..................");
                            final b_size =
                                ImageSizeGetter.getSize(FileInput(_blog_photo));
                            final u_size = ImageSizeGetter.getSize(
                                FileInput(_author_photo));

                            print(
                                "blog photo w ${b_size.width} h ${b_size.height} user photo w ${u_size.width} h ${u_size.height}");
                            if (((u_size.height < 210 || u_size.height > 330) ||
                                u_size.width != 400)) {
                              setState(() {
                                _author_photo = null;
                                executed = true;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'author image size error! please choose another one !.'),
                                    duration: Duration(milliseconds: 1500),
                                    width: 280.0,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              });
                            } else if (duration.inDays < 0) {
                              setState(() {
                                dateController.clear();
                                executed = true;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Incorrect date!.'),
                                    duration: Duration(milliseconds: 1500),
                                    width: 280.0,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              });
                            } else if (((b_size.height < 210 ||
                                    b_size.height > 330) ||
                                b_size.width != 400)) {
                              setState(() {
                                _blog_photo = null;
                                executed = true;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Blog image size error! please choose another one !.'),
                                    duration: Duration(milliseconds: 1500),
                                    width: 280.0,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              });
                            } else {
                              bool answer = await CreateBlogg().create(
                                  widget.uid,
                                  titleController.text,
                                  authorController.text,
                                  bodyController.text,
                                  venueController.text,
                                  date,
                                  _author_photo.path,
                                  _blog_photo.path,
                                  deletedd,
                                  context);
                              setState(() {
                                executed = answer;
                              });
                              titleController.clear();
                              bodyController.clear();
                              venueController.clear();
                              authorController.clear();
                              dateController.clear();
                              setState(() {
                                _author_photo = null;
                                _blog_photo = null;
                              });

                              date = '';
                            }
                          } else {
                            setState(() {
                              executed = true;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'all fields are required!. otherwise re-enter your date'),
                                  duration: Duration(milliseconds: 1500),
                                  width: 280.0,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            });
                          }
                        },
                        child: executed == false
                            ? CircularProgressIndicator()
                            : Text(
                                'Create',
                                style: TextStyle(fontSize: 16, color: log_txt),
                              ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
