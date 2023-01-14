import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';


class CreateBlog extends StatefulWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  File? image;
  String? base64Image;
  bool? showFeatureImage = false;
  Image? featureImage;
   String? author;
  File? author_photo;
  Image? author_image;

  String? title;
  String? body;
  List<String>? categories = ["Blog","Article"];
  String? categoryDropdownValue;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
    var _author_photo;
    var _blog_photo;
   final ImagePicker picker = ImagePicker();
  Future _pickAuthorCamera() async{
        XFile? photo = await picker.pickImage(source: ImageSource.camera,maxWidth: double.infinity,imageQuality: 50);
        setState(() {
          _author_photo=File(photo!.path);
        });
  }

  Future _pickBlogCamera() async{
        XFile? photo = await picker.pickImage(source: ImageSource.camera,maxWidth: 400,imageQuality: 50);
        setState(() {
          _blog_photo=File(photo!.path);
        });
  }
  Future _pickAuthorgallary() async{
        XFile? photo = await picker.pickImage(source: ImageSource.gallery,maxWidth: 400,imageQuality: 50);
        setState(() {
          _author_photo=File(photo!.path);
        });
  }

  Future _pickBlogGallary() async{
        XFile? photo = await picker.pickImage(source: ImageSource.gallery,maxWidth: 400,imageQuality: 50);
        setState(() {
          _blog_photo=File(photo!.path);
        });
  }
  void _pickCameraImage() async {
 

    XFile? photo = await picker.pickImage(source: ImageSource.camera,maxWidth: 400,imageQuality: 50);


    if (photo != null) {
   
      image = File(photo.path.toString());
      List<int> imageBytes = File(photo.path.toString()).readAsBytesSync();
      base64Image = base64Encode(imageBytes);

      setState(() {
        showFeatureImage = !showFeatureImage!;
        featureImage = Image.memory(base64Decode(base64Image!));
      });
    } else {
      // User canceled the picker
    }
  }


    

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color appbar=appColr;
         Color appbar2=appColr;
         Color log_page=Colors.white;
         Color log_txt=Colors.black87;
         Color input=Colors.white;
   
   
 final ThemeData mode = Theme.of(context);
var whichMode=mode.brightness;
if(whichMode==Brightness.dark){
  setState(() {
          appbar=Colors.black;
          appbar2=Colors.black38;
          log_page=Colors.black26;
          log_txt=Colors.white;
          input=Colors.black54;
      });
}
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appbar,
          centerTitle: true,
          title:
                 Text('Create Post', style: TextStyle(color: Colors.white)),
          leading: IconButton(
            onPressed: () {
            Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
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
                          onChanged: (text) {
                            title = text;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(8.0),child: Text("Profile Photo"),),
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
          ),)
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
                          onChanged: (text) {
                            title = text;
                          },
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
                        onChanged: (text) {
                          body = text;
                        },
                        maxLines: 10,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text('Category'),
                      const SizedBox(
                        width: 10,
                      ),
                      DropdownButton(
                        onChanged: (String? value) {
                          setState(() {
                            categoryDropdownValue = value;
                          });
                        },
                        value: categoryDropdownValue,
                        items: categories!
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Feature Image'),
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
          ),)
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
                          onPressed: () {
                     

                            if (title!.isNotEmpty &&
                                body!.isNotEmpty &&
                                categoryDropdownValue!.isNotEmpty &&
                                base64Image!.isNotEmpty) {
                              final data = {
                                "title": title,
                                "body": body,
                                "category": categoryDropdownValue,
                                "image": base64Image,
                                "owner": '',
                              };

                                  

                                titleController.clear();
                                bodyController.clear();
                                base64Image = "";

                                setState(() {
                                  showFeatureImage = false;
                                });
                       

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Post created!'),
                                  duration: Duration(milliseconds: 1500),
                                  width: 280.0,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                          child:  Text(
                            'Create',
                            style: TextStyle(fontSize: 16, color: log_txt),
                          )
                          )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
