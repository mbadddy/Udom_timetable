import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateBlogg {
  Future<bool> create(uid, title, author, body, venue, date, author_photo,
      blog_photo, List<String>? deleted, BuildContext context) async {
    try {
      bool returned;

      int entryNum = await countEntriesInZoneWard(uid) + 1;

      CollectionReference reff = FirebaseFirestore.instance.collection("blogg");
      reff.get().then((value) async {
        List<Map<dynamic, dynamic>>? list = [];
        list = value.docs.map((doc) => doc.data()).cast<Map>().toList();

        for (var doc in list) {
          if (doc["doc_id"] == entryNum) {
            entryNum++;
          }
        }
        returned = await postData(entryNum, uid, title, body, date, venue,
            context, author, author_photo, blog_photo);
        print("it extists...imaadd $entryNum...............");

        return returned;
      });

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
        await FirebaseFirestore.instance.collection('blogg').get();
    final List<DocumentSnapshot> documents = result2.docs;
    print("zipo ${documents.length}");
    return documents.length;
  }

  Future<bool> postData(entrynum, uid, title, body, date, venue, context,
      author, authorphoto, blogphoto) async {
    DateTime now = DateTime.now();
    print("it new $entrynum...................");
    var created = DateFormat("yyyy-MM-dd hh:mm:ss").format(now);
    final firebase =
        FirebaseFirestore.instance.collection("blogg").doc("$entrynum");
    storage.UploadTask uploadtask;
    storage.Reference ref = storage.FirebaseStorage.instance
        .ref()
        .child("blogs")
        .child("/$entrynum");
    print("${blogphoto}........................");
    ref.putFile(File(blogphoto));
    storage.Reference ref2 = storage.FirebaseStorage.instance
        .ref()
        .child("users")
        .child("/$entrynum");
    uploadtask = ref2.putFile(File(authorphoto));
    await uploadtask.whenComplete(() => null);
    String blogurl = await ref.getDownloadURL();
    String userurl = await ref2.getDownloadURL();
    final json = {
      'doc_id': entrynum,
      'uid': uid,
      'author_name': author,
      "title": title.trim(),
      "body": body.trim(),
      "date": date,
      "venue": venue.trim(),
      "blog": blogurl,
      "user": userurl,
      "created": created,
      "viewers": 0,
      "hide": false
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
  }
}
