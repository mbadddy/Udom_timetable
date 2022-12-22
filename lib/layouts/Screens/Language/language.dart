import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language extends StatelessWidget {
  final String title = 'language'.tr;
   String dropdownvalue = 'English';
  // final LanguageController _languageController = Get.find();
final List<String> lang=["English","Swajili","Spanish","Japanese"];
   
  @override
  Widget build(BuildContext context) {

    return  Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
              DropdownButton<String>(
                iconSize: MediaQuery.of(context).size.width * 0.045,
                isExpanded: false,
                isDense: false,
                value: lang[0],
                onChanged: (symbol) {
                   
                },
                items: lang.map((String e) {
                        return DropdownMenuItem<String>(
                          onTap: () {
                            
                          },
                      child: Text(
                        e,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                      value: e,
                    ); 
                }).toList(),     
                  
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}