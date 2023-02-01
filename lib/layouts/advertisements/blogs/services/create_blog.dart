import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import "package:path/path.dart";
class CreateBlogg {
  Future<bool> create(
      title,
      author,
      body,
      venue,
      date,
      author_photo,
      author_name,
      blog_photo,
      blog_name,
      List<String>? deleted,
      BuildContext context) async {
    try {
    
      final uid = FirebaseAuth.instance.currentUser!.uid;
      int entryNum = await countEntriesInZoneWard(uid) + 1;
        Box<List<String>>? deleteed=Hive.box<List<String>>("del_docs");
        deleted=deleteed.get("docs");
      if (deleted != null) {
        print("co null $deleted compare $entryNum");
        if (!deleted.contains(entryNum.toString())) {
          print("ipoooooooo");
         
          deleted.add(entryNum.toString());
           entryNum = int.parse(deleted[0]);
          deleteed.put("docs", deleted);
        }
        else{
            print("haipoooooooo");
          for(var x=0;x<deleted.length;x++){

            if(deleted[x]!=entryNum.toString()){
                entryNum=int.parse(deleted[x]);
                deleted.remove(deleted[x]);
                deleteed.put("docs", deleted);
              break;
            }
          }
        }
      }

      DateTime now = DateTime.now();
      var created = DateFormat("yyyy-MM-dd hh:mm:ss").format(now);
      final firebase =
          FirebaseFirestore.instance.collection("blogs").doc("$entryNum");
            storage.UploadTask uploadtask;
      storage.Reference ref = storage.FirebaseStorage.instance
          .ref()
          .child("blogs").child("/$entryNum");
          print("${blog_photo}........................");
      ref.putFile(File(blog_photo));
      storage.Reference ref2 = storage.FirebaseStorage.instance
          .ref()
          .child("users").child("/$entryNum");
      uploadtask = ref2.putFile(File(author_photo));
      await uploadtask.whenComplete(() => null);
      String blogurl = await ref.getDownloadURL();
      String userurl = await ref2.getDownloadURL();
      final json = {
        'doc_id': entryNum,
        'uid': uid,
        'author_name': author,
        "title": title.trim(),
        "body": body.trim(),
        "date": date,
        "venue": venue.trim(),
        "blog": blogurl,
        "user": userurl,
        "created": created,
        "viewers":0
      };
      firebase.set(json);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post created!'),
          duration: Duration(milliseconds: 1500),
          width: 280.0,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error on  create post!'),
          duration: Duration(milliseconds: 1500),
          width: 280.0,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return true;
    }
  }

  Future<int> countEntriesInZoneWard(uid) async {
    // CollectionReference blogs=FirebaseFirestore.instance.collection('blogs');
    // DocumentSnapshot result=await blogs.doc("").get();
    final QuerySnapshot result2 =
        await FirebaseFirestore.instance.collection('blogs').get();
    final List<DocumentSnapshot> documents = result2.docs;
    return documents.length;
  }
}
