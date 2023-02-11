
import 'dart:convert';


String blogToJson(Blog data) => json.encode(data.toJson());

class Blog {
    Blog({
        required this.date,
        required this.authorName,
        required this.venue,
        required this.uid,
        required this.viewers,
        required this.created,
        required this.body,
        required this.title,
        required this.blog,
        required this.user,
        required this.docId,
    });

    DateTime date;
    String authorName;
    String venue;
    String uid;
    int viewers;
    DateTime created;
    String body;
    String title;
    String blog;
    String user;
    int docId;

    Blog fromJson(Map<String, dynamic> json) => Blog(
        date: DateTime.parse(json["date"]),
        authorName: json["author_name"],
        venue: json["venue"],
        uid: json["uid"],
        viewers: json["viewers"],
        created: DateTime.parse(json["created"]),
        body: json["body"],
        title: json["title"],
        blog: json["blog"],
        user: json["user"],
        docId: json["doc_id"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "author_name": authorName,
        "venue": venue,
        "uid": uid,
        "viewers": viewers,
        "created": created.toIso8601String(),
        "body": body,
        "title": title,
        "blog": blog,
        "user": user,
        "doc_id": docId,
    };
}
