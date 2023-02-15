// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:udom_timetable/layouts/Screens/Colleges/Semister/alltimetable.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/combine/allcombines.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/Semister/day/day.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/advertisements/animated/dialogbox.dart';

class CombinedDays extends StatefulWidget {
  String semister;
  int year;
  String college;
  String programme;
  CombinedDays({
    Key? key,
    required this.semister,
    required this.year,
    required this.college,
    required this.programme,
  }) : super(key: key);
  @override
  _CombinedDaysState createState() => _CombinedDaysState();
}

class _CombinedDaysState extends State<CombinedDays> {
  final List<Widget> days = [
    OverallAttendanceCard(
      day: "Monday",
    ),
    OverallAttendanceCard(
      day: "Tuesday",
    ),
    OverallAttendanceCard(
      day: "Wednesday",
    ),
    OverallAttendanceCard(
      day: "Thursday",
    ),
    OverallAttendanceCard(
      day: "Friday",
    ),
  ];
  Box<List<String>>? all_timetable;
  List<String> coursees = [];
  List<String> lecturees = ["Diwani", "Siphaeli", "Minja", "Pascal"];
  List<String> venyues = [];

  List<String> time_from = [
    "07:30",
    "08:00",
    "08:30",
    "09:00",
    "09:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
    "13:00",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
    "15:30",
    "16:00",
    "16:30",
    "17:00",
    "17:30",
    "18:00",
    "18:30",
    "21:15",
    "21:20",
    "21:05",
    "20:45",
    "20:40",
    "20:42",
    "20:44",
    "20:46",
    "20:50",
    "19:00",
    "19:30",
    "21:30",
    "21:00",
    "22:30",
    "23:00",
    "19:40",
    "22:00",
    "19:50",
    "20:00"
  ];
  List<String> tooos = [
    "08:30",
    "09:00",
    "09:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
    "13:00",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
    "15:30",
    "16:00",
    "16:30",
    "17:00",
    "17:30",
    "18:00",
    "18:30",
    "19:00",
    "19:30",
    "20:00",
    "23:30"
  ];
  DropdownEditingController<String> course = DropdownEditingController();
  DropdownEditingController<String> time_f = DropdownEditingController();
  DropdownEditingController<String> time_t = DropdownEditingController();
  DropdownEditingController<String> venue = DropdownEditingController();
  Box<List<String>>? combinebox;
  @override
  void initState() {
    combinebox = Hive.box<List<String>>("combine");
    all_timetable = Hive.box<List<String>>("timetable");
    // deleteCobines();
    super.initState();
  }

  void deleteCobines() {
    combinebox!.deleteAll(combinebox!.keys);
  }

  String? instructorrr;
  void dialog(
      String day, String programe, String coll, String sem, String year) async {
    showDialog(
      context: context,
      builder: (context) {
        List<String> days = [];
        List<String> colleges = [];
        List<String> semisters = [];
        List<String> years = [];
        List<String> instructorss = [];
        List<String> programmes = [];
        List<String> courses = [];
        List<String> time_to = [];
        List<String> timefrom = [];
        List<String> venues = [];
        return Dialog(
          elevation: 1,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(day),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextDropdownFormField(
                        controller: course,
                        options: coursees,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            labelText: "Course"),
                        dropdownHeight: 220,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextDropdownFormField(
                        controller: venue,
                        options: venyues,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            labelText: "Venue"),
                        dropdownHeight: 220,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextDropdownFormField(
                        controller: time_f,
                        options: time_from,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            labelText: "From"),
                        dropdownHeight: 220,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextDropdownFormField(
                        controller: time_t,
                        options: tooos,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            labelText: "To"),
                        dropdownHeight: 220,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      if (cozessss != null) {
                        for (var x = 0; x < collegess!.length; x++) {
                          if (collegess![x] == widget.college &&
                              progssss![x] == widget.programme &&
                              semmsss![x] == widget.semister &&
                              yearssss![x] == widget.year.toString() &&
                              cozessss![x] == course.value) {
                            setState(() {
                              instructorrr = instrs![x];
                            });
                            print("instructor ${instrs![x]}");
                          }
                        }
                      }
                      var from = time_f.value;
                      var to = time_t.value;
                      int actual_from = int.parse(from!.split(":")[0]);
                      int actual_to = int.parse(to!.split(":")[0]);
                      if (time_f.value == null ||
                          course.value == null ||
                          time_t.value == null ||
                          venue.value == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("All Fields Are Required"),
                          width: 280.0,
                          behavior: SnackBarBehavior.floating,
                        ));
                      } else if (actual_to < actual_from) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Time Error"),
                          width: 280.0,
                          behavior: SnackBarBehavior.floating,
                        ));
                      } else {
                        if (combinebox!.get('days') == null) {
                          days.add(day);
                          combinebox!.put("days", days);
                        } else {
                          List<String>? dayss = combinebox!.get('days');
                          days.add(day);
                          for (var d = 0; d < dayss!.length; d++) {
                            print(dayss[d].toString() + " added");
                            days.add(dayss[d].toString());
                          }
                          combinebox!.put("days", days);
                        }

                        if (combinebox!.get('semisters') == null) {
                          semisters.add(sem);
                          combinebox!.put("semisters", semisters);
                        } else {
                          List<String>? semistes = combinebox!.get('semisters');
                          semisters.add(sem);
                          for (var d = 0; d < semistes!.length; d++) {
                            print(semistes[d].toString() + " added");
                            semisters.add(semistes[d].toString());
                          }
                          combinebox!.put("semisters", semisters);
                        }

                        // data=[,,,,,course.value!,time.value!,lecture.value!];

                        if (combinebox!.get('colleges') == null) {
                          colleges.add(coll);
                          combinebox!.put("colleges", colleges);
                        } else {
                          List<String>? coleges = combinebox!.get('colleges');
                          colleges.add(coll);
                          for (var d = 0; d < coleges!.length; d++) {
                            print(coleges[d].toString() + " added");
                            colleges.add(coleges[d].toString());
                          }
                          combinebox!.put("colleges", colleges);
                        }
                        if (combinebox!.get('instructors') == null) {
                          instructorss.add(instructorrr!);
                          combinebox!.put("instructors", instructorss);
                        } else {
                          List<String>? instructs =
                              combinebox!.get('instructors');
                          instructorss.add(instructorrr!);
                          for (var d = 0; d < instructs!.length; d++) {
                            print(instructs[d].toString() + " added");
                            instructorss.add(instructs[d].toString());
                          }
                          combinebox!.put("instructors", instructorss);
                        }

                        if (combinebox!.get('programmes') == null) {
                          programmes.add(programe);
                          combinebox!.put("programmes", programmes);
                        } else {
                          List<String>? programes =
                              combinebox!.get('programmes');
                          programmes.add(programe);
                          for (var d = 0; d < programes!.length; d++) {
                            print(programes[d].toString() + " added");
                            programmes.add(programes[d].toString());
                          }
                          combinebox!.put("programmes", programmes);
                        }
                        if (combinebox!.get('years') == null) {
                          years.add(year);
                          combinebox!.put("years", years);
                        } else {
                          List<String>? yrs = combinebox!.get('years');
                          years.add(year);
                          for (var d = 0; d < yrs!.length; d++) {
                            print(yrs[d].toString() + " added");
                            years.add(yrs[d].toString());
                          }
                          combinebox!.put("years", years);
                        }
                        if (combinebox!.get('courses') == null) {
                          courses.add(course.value.toString());
                          combinebox!.put("courses", courses);
                        } else {
                          List<String>? crses = combinebox!.get('courses');
                          courses.add(course.value.toString());
                          for (var d = 0; d < crses!.length; d++) {
                            print(crses[d].toString() + " added");
                            courses.add(crses[d].toString());
                          }
                          combinebox!.put("courses", courses);
                        }

                        if (combinebox!.get('time_from') == null) {
                          timefrom.add(time_f.value.toString());
                          combinebox!.put("time_from", timefrom);
                        } else {
                          List<String>? lect = combinebox!.get('time_from');
                          timefrom.add(time_f.value.toString());
                          for (var d = 0; d < lect!.length; d++) {
                            print(lect[d].toString() + " added");
                            timefrom.add(lect[d].toString());
                          }
                          combinebox!.put("time_from", timefrom);
                        }
                        if (combinebox!.get('time_to') == null) {
                          time_to.add(time_t.value.toString());
                          combinebox!.put("time_to", time_to);
                        } else {
                          List<String>? timess = combinebox!.get('time_to');
                          time_to.add(time_t.value.toString());
                          for (var d = 0; d < timess!.length; d++) {
                            print(timess[d].toString() + " added");
                            time_to.add(timess[d].toString());
                          }
                          combinebox!.put("time_to", time_to);
                        }

                        if (combinebox!.get('venues') == null) {
                          venues.add(venue.value.toString());
                          combinebox!.put("venues", venues);
                        } else {
                          List<String>? venuees = combinebox!.get('venues');
                          venues.add(venue.value.toString());
                          for (var d = 0; d < venuees!.length; d++) {
                            print(venuees[d].toString() + " added");
                            venues.add(venuees[d].toString());
                          }
                          combinebox!.put("venues", venues);
                        }
                        var coz = course.value;
                        var lec = time_f.value;
                        var ven = venue.value;
                        var ty = time_t.value;

                        course.value = null;
                        time_f.value = null;
                        time_t.value = null;
                        venue.value = null;

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Combine Saved Successfully"),
                          width: 280.0,
                          behavior: SnackBarBehavior.floating,
                        ));
                        Navigator.pop(context);
                        display(coll, programe, coz.toString(), year, sem,
                            lec.toString(), ven.toString(), ty.toString(), day);
                      }
                    },
                    child: Text("Save"))
              ],
            ),
          ),
        );
      },
    );
  }

  void display(String coll, String prog, String course, String year, String sem,
      String time_from, String venue, String time_to, String day) async {
    await animated_dialog_box.showScaleAlertBox(
      context: context,
      secondButton: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        color: Colors.white,
        child: Text('Delete'),
        onPressed: () {
          if (combinebox!.get("colleges") != null) {
            List<String>? collegee = combinebox!.get("colleges");
            for (var x = 0; x < collegee!.length; x++) {
              if (collegee[x] == coll) {
                collegee.removeWhere((element) => element == coll);
                print("remove ${coll}");
                combinebox!.put('colleges', collegee);
              }
            }
            List<String>? program = combinebox!.get("programmes");
            for (var x = 0; x < program!.length; x++) {
              if (program[x] == prog) {
                program.removeWhere((element) => element == prog);
                print("remove ${prog}");
                combinebox!.put('programmes', program);
              }
            }
            List<String>? yrs = combinebox!.get("years");
            for (var x = 0; x < yrs!.length; x++) {
              if (yrs[x] == year) {
                yrs.removeWhere((element) => element == year);
                print("remove ${year}");
                combinebox!.put('years', yrs);
              }
            }
            List<String>? semm = combinebox!.get("semisters");
            for (var x = 0; x < semm!.length; x++) {
              if (semm[x] == sem) {
                semm.removeWhere((element) => element == sem);
                print("remove ${sem}");
                combinebox!.put('semisters', semm);
              }
            }
            List<String>? cozes = combinebox!.get("courses");
            for (var x = 0; x < cozes!.length; x++) {
              if (cozes[x] == course) {
                cozes.removeWhere((element) => element == course);
                print("remove ${course}");
                combinebox!.put('courses', cozes);
              }
            }
            List<String>? tymes = combinebox!.get("time_to");
            for (var x = 0; x < tymes!.length; x++) {
              if (tymes[x] == time_to) {
                tymes.removeWhere((element) => element == time_to);
                print("remove ${time_to}");
                combinebox!.put('time_to', tymes);
              }
            }
            List<String>? lectureee = combinebox!.get("time_from");
            for (var x = 0; x < lectureee!.length; x++) {
              if (lectureee[x] == time_from) {
                lectureee.removeWhere((element) => element == time_from);
                print("remove ${time_from}");
                combinebox!.put('time_from', lectureee);
              }
            }
            List<String>? venyus = combinebox!.get("venues");
            for (var x = 0; x < venyus!.length; x++) {
              if (venyus[x] == venue) {
                venyus.removeWhere((element) => element == venue);
                print("remove ${venue}");
                combinebox!.put('venues', venyus);
              }
            }
            List<String>? deys = combinebox!.get("days");
            for (var x = 0; x < deys!.length; x++) {
              if (deys[x] == day) {
                deys.removeWhere((element) => element == day);
                print("remove ${day}");
                combinebox!.put('days', deys);
              }
            }

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Combine Deleted Successfully"),
              width: 280.0,
              behavior: SnackBarBehavior.floating,
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("No data Found To Delete"),
              width: 280.0,
              behavior: SnackBarBehavior.floating,
            ));
          }
          Navigator.pop(context);
        },
      ),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15, bottom: 10),
            child: Text("Your Combine TimeTable Is As Follows..."),
          ),
          Text("College: ${coll}"),
          Text("Programme: ${prog}"),
          Text("Year: ${year}"),
          Text("Semister: ${sem}"),
          Text("Day: ${day}"),
          Text("Course: ${course}"),
          Text("Instructor: ${instructorrr}"),
          Text("Time To: ${time_to}"),
          Text("Time From: ${time_from}"),
          Text("Venue: ${venue}"),
        ],
      ),
    );
  }

  List<String>? collegess;
  List<String>? progssss;
  List<String>? dayssss;
  List<String>? semmsss;
  List<String>? yearssss;
  List<String>? venyuuuus;
  List<String>? cozessss;
  List<String>? instrs;
  List<String>? tymeee;
  List<String>? categoryyyyyy;
  @override
  Widget build(BuildContext context) {
    setState(() {
      collegess = all_timetable!.get("colleges");
      progssss = all_timetable!.get("programmes");
      //  dayssss=all_timetable!.get("days");
      semmsss = all_timetable!.get("semisters");
      yearssss = all_timetable!.get("years");
      venyuuuus = all_timetable!.get("venues");
      cozessss = all_timetable!.get("courses");
      instrs = all_timetable!.get("lectures");
      tymeee = all_timetable!.get("times");
      categoryyyyyy = all_timetable!.get("categories");
      if (collegess != null) {
        for (var x = 0; x < collegess!.length; x++) {
          if (collegess![x] == widget.college &&
              progssss![x] == widget.programme &&
              semmsss![x] == widget.semister &&
              yearssss![x] == widget.year.toString()) {
            if (coursees.isEmpty) {
              coursees.add(cozessss![x]);
            } else {
              if (coursees.contains(cozessss![x])) {
              } else {
                coursees.add(cozessss![x]);
              }
            }
            if (venyues.isEmpty) {
              venyues.add(venyuuuus![x]);
            } else {
              if (venyues.contains(venyuuuus![x])) {
                print("existing...............................skipp");
              } else {
                venyues.add(venyuuuus![x]);
              }
            }
          }
        }
      }
    });

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(bottom: 60),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  Widget myday = days[index];
                  return ListTile(
                    title: myday,
                    onTap: () {
                      switch (index) {
                        case 0:
                          dialog("Monday", widget.programme, widget.college,
                              widget.semister, widget.year.toString());

                          break;
                        case 1:
                          dialog("Tuesday", widget.programme, widget.college,
                              widget.semister, widget.year.toString());
                          break;
                        case 2:
                          dialog("Wednesday", widget.programme, widget.college,
                              widget.semister, widget.year.toString());
                          break;
                        case 3:
                          dialog("Thursday", widget.programme, widget.college,
                              widget.semister, widget.year.toString());
                          break;
                        case 4:
                          dialog("Friday", widget.programme, widget.college,
                              widget.semister, widget.year.toString());
                          break;
                        default:
                          print("sunday");
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: days.length)));
  }
}
