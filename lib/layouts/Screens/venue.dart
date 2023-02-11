// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/Screens/Venue/specific_venue.dart';

import 'Venue/venuDesc.dart';

class Venue extends StatefulWidget {
  const Venue({super.key});

  @override
  State<Venue> createState() => _VenueState();
}

class _VenueState extends State<Venue> {
  SharedPreferences? sharedPreferences;
  Box<List<String>>? all_timetable;
  String? favourate;

  Future getPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      favourate = sharedPreferences!.getString("college")!;
    });
  }

  //by day
  List<String>? coll;
  List<String>? prog;
  List<String>? yea;
  List<String>? sem;
  List<String>? day;
  bool? combine;
  Future getByDay() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      coll = sharedPreferences!.getStringList("colleges");
      prog = sharedPreferences!.getStringList("programes");
      yea = sharedPreferences!.getStringList("years");
      sem = sharedPreferences!.getStringList("semisters");
      day = sharedPreferences!.getStringList("days");
      combine = sharedPreferences!.getBool("favourate");
    });
  }

  @override
  void initState() {
    all_timetable = Hive.box<List<String>>("timetable");
    getPreferences();
    getByDay();
    super.initState();
  }

  void popupAction(String option) {
    print(option);
  }

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
  DropdownEditingController<String> time_f = DropdownEditingController();
  DropdownEditingController<String> time_t = DropdownEditingController();
  List<String> options = ['Change Favourate', 'Delete Favourate'];
  List<String>? collgs;
  List<String>? venyuuuuuus;
  List<String>? tymesss;
  List<String>? dayyys;
  List<String> venues = [];

  String? colll;
  var valu1;
  var value2;
  bool filter = false;
  bool error = false;
  void filterVenue(value) {
    DateTime noww = DateTime.now();
    var today = DateFormat.EEEE().format(noww);
    setState(() {
      filter = true;
      if (time_f.value != null && time_t.value != null) {
        if (venyuuuuuus != null) {
          for (var t = 0; t < tymesss!.length; t++) {
            if (dayyys![t] == today) {
              var timeFrom = tymesss![t].split("-")[0];
              var timeTo = tymesss![t].split("-")[1];
              var hrsf_input = time_f.value.toString().split(":")[0];
              var hrst_input = time_t.value.toString().split(":")[0];
              var mnsf_input = time_f.value.toString().split(":")[1];
              var mnst_input = time_t.value.toString().split(":")[1];
              //check time differences f & t
              var noww = DateTime.now();
              var splitted_now = noww.toString().split(" ");
              var splitted_now2 = noww.toString().split(" ");
              var dttt1;
              var dttt2;
              var dttttt1;
              var dttttt2;
              var category;
              var c_time = time_f.value.toString();
              var td_time = time_t.value.toString();
              c_time = "${c_time}:00";
              td_time = "${td_time}:00";

              splitted_now2[1] = c_time;
              dttt1 = splitted_now2;
              splitted_now[1] = td_time;
              dttt2 = splitted_now;
              dttttt1 = dttt1[0] + " " + dttt1[1];
              dttttt2 = dttt2[0] + " " + dttt2[1];
              DateTime dt1 = DateTime.parse(dttttt1);
              DateTime dt2 = DateTime.parse(dttttt2);
              Duration durr = dt2.difference(dt1);
              print("duration .........${durr.inMinutes}............");
              //end

              var hrsfrt_input = timeFrom.toString().split(":")[0];
              var hrstrt_input = timeTo.toString().split(":")[0];

              var mnsfrt_input = timeFrom.toString().split(":")[1];
              var mnstrt_input = timeTo.toString().split(":")[1];
              print("compare f $timeFrom......${time_f.value}");
              print("compare t $timeTo......${time_t.value}");
              if (durr.inMinutes <= 0) {
                error = true;
              } else {
                error = false;
                if ((int.parse(hrsf_input) + (int.parse(mnsf_input) / 60) >= int.parse(hrsfrt_input) + (int.parse(mnsfrt_input) / 60) &&
                            int.parse(hrsf_input) + (int.parse(mnsf_input) / 60) <=
                                int.parse(hrstrt_input) +
                                    (int.parse(mnstrt_input) / 60) ||
                        int.parse(hrst_input) + (int.parse(mnst_input) / 60) >
                                int.parse(hrsfrt_input) +
                                    (int.parse(mnsfrt_input) / 60) &&
                            int.parse(hrst_input) + (int.parse(mnst_input) / 60) <=
                                int.parse(hrstrt_input) +
                                    (int.parse(mnstrt_input) / 60)) ||
                    (int.parse(hrsf_input) + (int.parse(mnsf_input) / 60) <=
                                int.parse(hrsfrt_input) +
                                    (int.parse(mnsfrt_input) / 60) &&
                            int.parse(hrsfrt_input) + (int.parse(mnstrt_input) / 60) <
                                int.parse(hrst_input) +
                                    (int.parse(mnst_input) / 60) ||
                        int.parse(hrstrt_input) + (int.parse(mnstrt_input) / 60) >=
                                int.parse(hrst_input) +
                                    (int.parse(mnst_input) / 60) &&
                            int.parse(hrstrt_input) + (int.parse(mnstrt_input) / 60) <
                                int.parse(hrsf_input) + (int.parse(mnsf_input) / 60))) {
                  print("${venyuuuuuus![t]}.....................allocated");
                  venues.removeWhere((element) => element == venyuuuuuus![t]);
                } else {
                  if (!venues.contains(venyuuuuuus![t])) {
                    venues.add(venyuuuuuus![t]);
                  }
                  print("${dayyys![t]}....................");
                  print("${venyuuuuuus![t]}.....................free");
                }
              }
            }
          }
        }
        //apa
        if (error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Time Error")));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (coll != null && coll!.isNotEmpty) {
        colll = coll![0];
      }

      tymesss = all_timetable!.get("times");
      dayyys = all_timetable!.get("days");
      collgs = all_timetable!.get("colleges");
      venyuuuuuus = all_timetable!.get("venues");
      if (venyuuuuuus != null && colll != null) {
        for (var v = 0; v < venyuuuuuus!.length; v++) {
          if (collgs![v] == colll && filter == false) {
            if (venues.isEmpty) {
              venues.add(venyuuuuuus![v]);
            } else {
              if (!venues.contains(venyuuuuuus![v])) {
                venues.add(venyuuuuuus![v]);
              }
            }
          }
        }
      }
    });
    print(filter);
    Color appbar = appColr;

    final ThemeData mode = Theme.of(context);
    var whichMode = mode.brightness;
    if (whichMode == Brightness.dark) {
      setState(() {
        appbar = Colors.black12;
      });
    }
    DateTime noww = DateTime.now();
    var today = DateFormat.EEEE().format(noww);

    //searching
    //end
    return Scaffold(
        appBar: AppBar(
          title: const Text("Venue"),
          backgroundColor: appbar,
          actions: [
            IconButton(
              onPressed: () {
                // method to show the search bar
                if (coll != null && coll!.isNotEmpty) {
                  showSearch(
                    context: context,
                    // delegate to customize the search bar
                    delegate:
                        CustomSearchDelegate(venues: venues, collg: colll!),
                  );
                }
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(right: 5, left: 5, bottom: 5),
          child: coll == null || coll!.isEmpty
              ? Center(
                  child: Text("No Favourate Available"),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    coll != null && coll!.isNotEmpty
                        ? VDescription(
                            college: coll![0],
                            total: '${venues.length}',
                          )
                        : const Center(child: Text("No favourate Available")),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Search For ${today} Free Venues"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextDropdownFormField(
                              onChanged: filterVenue,
                              controller: time_f,
                              options: time_from,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  labelText: "Time From"),
                              dropdownHeight: 220,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextDropdownFormField(
                              onChanged: filterVenue,
                              controller: time_t,
                              options: tooos,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.arrow_drop_down),
                                  labelText: "Time To"),
                              dropdownHeight: 220,
                            ),
                          ),
                        ],
                      ),
                    ),
                    (coll != null) && coll!.isNotEmpty
                        ? Expanded(
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  String name;

                                  name = venues[index];

                                  return ListTile(
                                    leading: CircleAvatar(
                                        backgroundColor: appbar,
                                        child: Text(name
                                            .toString()
                                            .substring(0, 3))),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 20,
                                    ),
                                    title: Text(name),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SpecificVenue(
                                                    venue: name,
                                                    college: colll!,
                                                  )));
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) => Divider(),
                                itemCount: venues.length))
                        : coll != null && coll!.isNotEmpty
                            ? Expanded(
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      String name;

                                      name = venues[index];
                                      //
                                      return ListTile(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SpecificVenue(
                                                        venue: name,
                                                        college: colll!,
                                                      )));
                                          print("halloe .........");
                                        },
                                        leading: Icon(Icons.class_),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 20,
                                        ),
                                        title: Text(name),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Divider(),
                                    itemCount: venues.length))
                            : const Center(
                                child: Text("No favourate Available")),
                  ],
                ),
        ));
  }
}

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  List<String> venues;
  String collg;
  CustomSearchDelegate({
    required this.venues,
    required this.collg,
  });

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_ios_new),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in venues) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in venues) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];

        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SpecificVenue(
                          venue: result,
                          college: collg,
                        )));
          },
          leading: Icon(Icons.class_),
          title: Text(result),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
          ),
        );
      },
    );
  }
}
