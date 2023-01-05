import 'dart:io';

import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:translator/translator.dart';

class TranlateWord extends StatefulWidget {
  const TranlateWord({super.key});

  @override
  State<TranlateWord> createState() => _TranlateWordState();
}

class _TranlateWordState extends State<TranlateWord> {

  List<String> nounsList=[];
  var wordss=0;

  generateNouns() {
    nouns.take(500).forEach((element) {
      nounsList.add(element.toString());
    });
  }
//box
Box<String>? swahili;
Box<String>? france;
Box<String>? arabic;
 
 DropdownEditingController<String> from=DropdownEditingController();
 DropdownEditingController<String> to=DropdownEditingController();
 TextEditingController source=TextEditingController();
 List<String> from_list=["english","swahili","Arabic","france"];
 List<String> to_list=["english","swahili","Arabic","france"];
  @override
  void initState() {
   swahili=Hive.box<String>("swahili");
   france=Hive.box<String>("arabic");
   arabic=Hive.box<String>("france");
   swahili!.deleteAll(swahili!.keys);
   generateNouns() ;
    super.initState();
  }


 final translator = GoogleTranslator();
 int state=0;
 int progress=0;
 String result='';
  translate(value)async{

 if(from.value!=null && to.value!=null && source.value!=null){
  if(from.value==to.value){
   print("error....................      .......");
  }
  else{
   if(from.value!="english"){
     
  }
  else{
       if(to.value=="swahili"){
        setState(() {
          state=1;
        });
       
         if(swahili!.isEmpty){
            print("translating..............");
          for(var w=0;w<nounsList.length;w++){
           
           var translated=await translator.translate(nounsList[w],to:"sw");
           swahili!.put(nounsList[w].toLowerCase(), translated.toString().toLowerCase());
           setState(() {
            progress++; 
           });
           
           
         }
         setState(() {
          state=2;
           });
         }
         else{
        if(swahili!.get(source.value.toString().toLowerCase())!=null){
           setState(() {
             state=2;
             result='${swahili!.get(source.value.toString().toLowerCase())}';
           });
         }
         else{

          var translated=await translator.translate(source.value.toString(),to:"sw");
          swahili!.put(source.value.toString().toLowerCase(), translated.toString().toLowerCase());
          print(swahili!.length);
          setState(() {
          state=2;
           });
         
         if(swahili!.get(source.value.toString().toLowerCase())!=null){
           print('${source.value} is ${swahili!.get(source.value.toString().toLowerCase())}');
           setState(() {
              result='${swahili!.get(source.value.toString().toLowerCase())}';
           });
         }
         else{
          setState(() {
            result="failed to translate";
          });
           print("error on translate....................      .......");
         }
         }
         }
   

       
       }
       else if(to.value=="Arabic"){

       }
  }
  }
  
   print("from ${from.value}....... to......${to.value}..");
 }
  }
  //writing to a file
  Future<String> get local_path async{
    final directory=await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> _localFile(file) async{
    final path=await local_path;
    return File("${path}/$file.txt");
    
  }
  Future<int> readData(file) async{
    try {
      final filee=await _localFile(file);
      String contents=await filee.readAsString();

      return int.parse(contents);
    } catch (e) {
      return 0;
    }
  }
  Future<File> writeData(filee,data) async{
    final file=await _localFile(filee);
    return file.writeAsString("$data");
  }


  //end
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Translate  words ${wordss}"),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new_rounded,size: 15,)),
        actions: []),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(10),
          child: TextFormField(
            controller:source,
          decoration: const InputDecoration(
         border: UnderlineInputBorder(),
          labelText: 'Enter your text',
         ),
         ),),
          Padding(padding: EdgeInsets.all(10),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: TextDropdownFormField(
              controller: from,
              onChanged: translate,
             decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.arrow_drop_down),
              labelText: "From"),
              options: from_list,)),
              SizedBox(width: 10,),
             Expanded(child: TextDropdownFormField(
              onChanged: translate,
              controller: to,
             decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.arrow_drop_down),
              labelText: "To"),
              options: to_list,)),
          ],),
          ),
          Padding(padding: EdgeInsets.all(10),
          child: state==0?Text("Waiting...................."):
          state==1?Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircularProgressIndicator(),
            Padding(padding: EdgeInsets.all(10),
            child: Text("Dowloading package........${(progress/(nounsList.length))*100}%"),)
          ],):Text("$result"),),
          Expanded(
            child: ListView.builder(
            itemCount: nounsList.length,
            itemBuilder: (context, index) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                  wordss=nounsList.length;
                });
              },);
             return ListTile(
              
              title: Text(nounsList[index]),
              subtitle: Text(nounsList[index]),
             );
          },)),
          
        ],
      ),
    );
  }
}