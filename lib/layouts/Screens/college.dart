import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udom_timetable/layouts/Screens/Colleges/college_activity.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/Screens/components/constants.dart';
import 'package:udom_timetable/layouts/Screens/components/customdivider.dart';

class College extends StatefulWidget {
  const College({super.key});

  @override
  State<College> createState() => _CollegeState();
}

class _CollegeState extends State<College> {
   void popupAction(String option) {
    if(option=='Setting'){
    
    }
    if(option=='Share'){
      
    }
         print(option);
  }



  @override
  Widget build(BuildContext context) {
      Color appbar=appColr;
  
   final ThemeData mode = Theme.of(context);
   var whichMode=mode.brightness;
   if(whichMode==Brightness.dark){
  setState(() {
          appbar=Colors.black12;
      });
}
     List<String> options = ['Setting', 'share'];
    Size size=MediaQuery.of(context).size;
    return Scaffold(
            appBar: AppBar(
        title:new Text("Colleges"),
        
        backgroundColor: appbar,
        actions: [
        PopupMenuButton(
          position: PopupMenuPosition.under,
          onSelected:popupAction,
          itemBuilder: (context) => 
        
         options.map((String option) {
              return PopupMenuItem<String>(
                 value: option,
                child: Text(option),
              );
            }).toList(),
        )
        ],
        
      ),
      body: 
      Padding(
        child: ListView(
          padding: EdgeInsets.only(right:5,left:10),
          children: <Widget>[
            _CategoriesSection(),
            CustomDivider(),
            SizedBox(height: 20.0),
         
          ],
        ),
        padding: EdgeInsets.only(right: 20),
        )
      
      
    );
  }
}
class _CategoriesSection extends StatefulWidget {
  const _CategoriesSection({super.key});

  @override
  State<_CategoriesSection> createState() => __CategoriesSectionState();
}

class __CategoriesSectionState extends State<_CategoriesSection> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: Constants.categories.length,
      itemBuilder:(context, index) {
         Map category = Constants.categories[index];
         return ListTile(
          
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Collegee(title: category['title']),));
          },
          contentPadding: EdgeInsets.all(5),
          leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(60)),
                      height: 50,
                      width: 50,
                      child: ClipRRect(                
                     borderRadius: BorderRadius.circular(16),
                    child:
                      Image(
                    image: AssetImage(category['image']),
                  fit: BoxFit.cover,
                    ),
                    ),
                    ),


          title: Text(category['title']),
          subtitle: Text(category["subtitle"]),
          trailing: Icon(Icons.arrow_forward_ios_outlined,size: 20,),
         );
      },
      separatorBuilder: (context, index) {
        return CustomDivider();
      },
    );
  }
}