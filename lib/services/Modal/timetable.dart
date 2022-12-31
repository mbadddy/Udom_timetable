

import 'dart:convert';

Timetable timetableFromJson(String str) => Timetable.fromJson(json.decode(str));

String timetableToJson(Timetable data) => json.encode(data.toJson());

class Timetable {
    Timetable({
        required this.data,
    });

    List<Datum> data;

    factory Timetable.fromJson(Map<String, dynamic> json) => Timetable(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
      required this.id,
       required this.day,
       required this.time,
       required this.course,
        required this.studentId,
       required this.instructor,
       required this.venue,
    });

    int id;
    int day;
    String time;
    String course;
    int studentId;
    String instructor;
    String venue;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        day: json["day"],
        time: json["time"],
        course: json["course"],
        studentId: json["student_id"],
        instructor: json["instructor"],
        venue: json["venue"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "time": time,
        "course": course,
        "student_id": studentId,
        "instructor": instructor,
        "venue": venue,
    };
}
