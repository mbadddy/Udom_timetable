import 'dart:convert';
import 'dart:io';

import "package:http/http.dart" as http;
class LoginService{
  Future<List<String>?> login(username,password)async{
    print("ipo njeee..... $username.....$password");
    var url="http://192.168.137.1:8000/blog/login/";
    try {
       print("trying....");
        var response=await http.post(Uri.parse(url),
      body: jsonEncode({
        "username":username,
        "password":password
      }),
      headers: {
        "Content-Type":"application/json"
      });
     print("Executed.......");
      if(response.statusCode==200){
         print("success.......");

        var data=jsonDecode(response.body);
        if(data['msg']=="success"){
          return [
                 "${data["tokens"]["access"]}",
                 "${data["tokens"]["refresh"]}"
          ];
        }
        else{
         print("Forbidden.......");
        return ["forbidden",""];
       }
       }
       
    } catch (e) {
       print("problem.......");
      return null;
    }
    
   
  }
}