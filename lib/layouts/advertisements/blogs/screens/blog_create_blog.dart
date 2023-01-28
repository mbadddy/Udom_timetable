import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/services/create_blog.dart';

class CreateBlog extends StatefulWidget {
  final String refresh_token;
  final String token;
  const CreateBlog({Key? key, required this.refresh_token, required this.token}) : super(key: key);

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {



 
  
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
   String? date;
  final TextEditingController venueController = TextEditingController();
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


SharedPreferences? sharedPreferences;
  Future removeTokens()async{
      sharedPreferences=await SharedPreferences.getInstance();
      setState(() {
        sharedPreferences!.remove("token");
      sharedPreferences!.remove("token_refresh");
      });
      
  }
  Future getTokens()async{
    sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
    sharedPreferences!.getString("token");
    sharedPreferences!.getString("token_refresh");
    });
  }
  @override
  void initState() {
    getTokens();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     getTokens();
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
    return Scaffold(
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
          actions: [
            IconButton(onPressed: ()async {
              await removeTokens();
              await getTokens();
              Navigator.pop(context);
            }, icon: Icon(Icons.logout))
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
                SizedBox(height: 20,),
                Container(
                  height: 80,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Event Date'),
                      Expanded(
                         child: DateTimePicker(
                              initialValue: '',
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              dateLabelText: 'Date',
                              onChanged: (value) {
                                setState(() {
                                  date=value;
                                });
                              },
                              validator: (val) {
                                print(val);
                                return null;
                              },
                              onSaved: (val) => print(val),
                            )
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
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
                SizedBox(height: 20,),
               
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Feature Image'),
                      SizedBox(height: 15,),
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
                            print("file ${_author_photo}");
                              // CreateBlogg().create( titleController.text, bodyController.text,
                              //  venueController.text, date, _, blog_photo)
                               if (titleController.text.isNotEmpty &&
                                bodyController.text.isNotEmpty &&
                                date!.isNotEmpty &&
                                _author_photo!.isNotEmpty && _blog_photo.isNotEmpty) {
                                  
                                titleController.clear();
                                bodyController.clear();
                                venueController.clear();
                                authorController.clear();  

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
    );
  }
}
