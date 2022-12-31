// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/programme.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/programmes.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/Screens/SharedPreference/preference.dart';
import 'package:udom_timetable/layouts/Screens/components/customdivider.dart';

class Collegee extends StatefulWidget {

  String title;
   Collegee({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<Collegee> createState() => _CollegeeState();
}

class _CollegeeState extends State<Collegee> {
   SharedPreferences? sharedPreferences;
   String? college;
   Future<void> setPreference(bool value) async{
  sharedPreferences=await SharedPreferences.getInstance();
   sharedPreferences!.setBool("favouratecoll", value);
     }
      Future<void> setCollegePref(String value) async{
  sharedPreferences=await SharedPreferences.getInstance();
   sharedPreferences!.setString("college", value);
     }
          Future<void> removeCollegePref(String value) async{
  sharedPreferences=await SharedPreferences.getInstance();
   sharedPreferences!.remove("college");
     }

  @override
  void initState() {
   getPreference();
    super.initState();
  }
  
 Color favourate=Colors.white;
 
  bool? myfavourate;
   Future getPreference() async{
         sharedPreferences=await SharedPreferences.getInstance();
         setState(() {
          myfavourate=sharedPreferences!.getBool("favouratecoll")!;  
         });
       
     }
  @override
  Widget build(BuildContext context) {
    // getPreference();
     setCollegePref(widget.title);
    if(myfavourate!=null){
      print("fref "+myfavourate.toString());
      if(myfavourate==true){
        setState(() {
          favourate=Colors.red;
          setCollegePref(widget.title);
        });
      }
      else{
        setState(() {
          favourate=Colors.white;
           removeCollegePref('college'); 
                });
      }
      
        }
        else{
        myfavourate=false;
        print("combref imewekwa ");
        }
     
     Color appbar=appColr;
   
 final ThemeData mode = Theme.of(context);
var whichMode=mode.brightness;
if(whichMode==Brightness.dark){
  setState(() {
          appbar=Colors.black12;
      });
}
// if(myfavourate){
//   setState(() {
//     favourate=Colors.red;
//   });
// }
 
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: () {
          Navigator.of(context).pop();
        },),
        centerTitle: true,
           backgroundColor: appbar,
        title:new Text(widget.title),
        
        actions: [
           IconButton(
            color: favourate,
            onPressed: () {  
             
                  setState(() {
                     if(myfavourate==null || myfavourate==true){
                     myfavourate=false;
                    
                    setPreference(myfavourate!);
                     getPreference();
                     }
                     else{
                       myfavourate=true;
                
                      setPreference(myfavourate!);
                       getPreference();
                     }
                 
                    
                  });
            
          
          
            },
            icon:  Icon(Icons.star_border_purple500),
          ),
       IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                context: context,
                // delegate to customize the search bar
                delegate: CustomSearchDelegate(title: widget.title),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
        
      ),
      body: Padding(padding: EdgeInsets.only(right: 10),
      child: ListView.separated(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: Programe.programmes[0][widget.title].length,
      itemBuilder:(context, index) {
         Map category = Programe.programmes[0][widget.title][index];
        return ListTile(
          
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Programme(programe: category['title'], year: category['year'], subtitle: category['subtitle'], college:widget.title,),));
          },
          contentPadding: EdgeInsets.all(5),
          leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(60)),
                      height: 50,
                      width: 50,
                      child:Icon(Icons.school),
                    ),
          title: Text(category['title']),
          subtitle: Text(category["subtitle"]),
          trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20,),
         );
          },
      separatorBuilder: (context, index) {
        return CustomDivider();
      },
    ),)
    );
  }
}



class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  String title;
  CustomSearchDelegate({required this.title});
     
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
    for (var fruit in Programe.programmes[0][title]) {
    
      if (fruit['title'].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit['title']);
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
     List<int> years = [];
      List<String> subtitles = [];
    for (var fruit in Programe.programmes[0][title]) {
      if (fruit['title'].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit['title']);
        years.add(fruit['year']);
        subtitles.add(fruit['subtitle']);
      
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        int year = years[index];
        String subtitle=subtitles[index];
        return ListTile(
          onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => Programme(programe:result, year: year, subtitle: subtitle, college: title,),));
          },
          leading: Icon(Icons.school_outlined),
          title: Text(result),
          trailing: Icon(Icons.arrow_forward_ios_rounded,size: 18,),
        );
      },
    );
  }
}