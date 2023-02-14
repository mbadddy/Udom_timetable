import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udom_timetable/layouts/admin/Posts/posts.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  Future setSwitchOnn(bool isSwitchedd, String id) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection("users").doc("$id");
    final data = {"active": isSwitchedd};
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

  Stream<QuerySnapshot<Map<String, dynamic>>>? users;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData) {
          return ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: snapshot.data!.docs.map((document) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PostsManage(username: document['email'], uid: document['uid'],),
                  ));
                },
                onLongPress: () {
                  
                },
                title: Text("${document['email']}"),
                subtitle: Text('${document['phone']}'),
                leading: document['active']
                    ? CircleAvatar(
                        child: Icon(
                        Icons.check,
                        color: Colors.green,
                      ))
                    : CircleAvatar(
                        child: Icon(
                        Icons.warning_amber_sharp,
                        color: Colors.red,
                      )),
                trailing: Switch(
                  onChanged: (value) {
                    toggleSwitchh(document['active'], document['email']);
                  },
                  value: document['active'],
                  activeColor: Colors.blue,
                  activeTrackColor: Colors.yellow,
                  inactiveThumbColor: Colors.redAccent,
                  inactiveTrackColor: Colors.orange,
                ),
              );
            }).toList(),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
