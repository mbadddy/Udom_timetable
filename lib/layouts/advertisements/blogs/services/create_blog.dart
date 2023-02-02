import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class CreateBlogg {
  Future<bool> create(title, author, body, venue, date, author_photo,
      blog_photo, List<String>? deleted, BuildContext context) async {
    try {
      bool returned;
      final uid = FirebaseAuth.instance.currentUser!.uid;
      int entryNum = await countEntriesInZoneWard(uid) + 1;
      Box<List<String>>? deleteed = Hive.box<List<String>>("del_docs");
      deleted = deleteed.get("docs");
      if (deleted != null) {
        print("co null $deleted compare $entryNum");
        if (!deleted.contains(entryNum.toString())) {
          print("ipoooooooo");

          deleted.add(entryNum.toString());
          entryNum = int.parse(deleted[0]);
          deleted.remove(deleted[0]);
          deleteed.put("docs", deleted);
        } else {
          print("haipoooooooo");
          for (var x = 0; x < deleted.length; x++) {
            if (deleted[x] != entryNum.toString()) {
              entryNum = int.parse(deleted[x]);
              print("${deleted[x]} now equal entry $entryNum");
              deleted.remove(deleted[x]);
              print("${deleted[x]} removed");
              deleteed.put("docs", deleted);
            } else {
              deleted.remove(deleted[x]);
              deleteed.put("docs", deleted);
            }
          }
        }
        returned = await postData(entryNum, uid, title, body, date, venue,
            context, author, author_photo, blog_photo);
      } else {
        DocumentReference reff =
            FirebaseFirestore.instance.collection("blogs").doc("$entryNum");
        reff.get().then((value) {
          if (value.exists) {
            entryNum++;
            print("it extists...imaadd $entryNum...............");
          }
        });
        returned = await postData(entryNum, uid, title, body, date, venue,
            context, author, author_photo, blog_photo);
      }

      return returned;
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

  Future<bool> postData(entrynum, uid, title, body, date, venue, context,
      author, authorphoto, blogphoto) async {
    DateTime now = DateTime.now();
    print("it new $entrynum...................");
    var created = DateFormat("yyyy-MM-dd hh:mm:ss").format(now);
    final firebase =
        FirebaseFirestore.instance.collection("blogs").doc("$entrynum");
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
      "viewers": 0
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
