import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udom_timetable/layouts/Screens/Colors/colors.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/fade_animation.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/screens/blog_create_blog.dart';
import 'package:udom_timetable/layouts/advertisements/blogs/services/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    SharedPreferences? sharedPreferences;
  var token;
  var token_refresh;
  var attempting=false;
  Future getTokens()async{
    sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      token=sharedPreferences!.getString("token");
      token_refresh=sharedPreferences!.getString("token_refresh");
    });
  }
    Future setTokens(tokenn,token_refreshh)async{
    sharedPreferences=await SharedPreferences.getInstance();
             sharedPreferences!.setString("token",tokenn);
             sharedPreferences!.setString("token_refresh",token_refreshh);
             getTokens();
     }
     @override
  void initState() {
        getTokens();
    super.initState();
  }
  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();
  var message='';
  @override
  Widget build(BuildContext context) {
         Color appbar=appColr;
         Color appbar2=appColr2;
         Color log_page=Colors.white;
         Color log_txt=Colors.black87;
         Color input=Colors.white;
   
   
 final ThemeData mode = Theme.of(context);
var whichMode=mode.brightness;
if(whichMode==Brightness.dark){
  setState(() {
          appbar=Colors.black12;
          appbar2=Colors.black38;
          log_page=Colors.black26;
          log_txt=Colors.white;
          input=Colors.black54;
      });
}
 getTokens();
if(token!=null){
  print("token... $token");
}
    return Scaffold(
      appBar: AppBar(backgroundColor: appbar,
      leading: IconButton(onPressed: () {
        Navigator.of(context).pop();
      }, icon: Icon(Icons.arrow_back_ios_new)),),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              // Colors.purple,
              appbar,
              appbar2,
            ])),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(20),
            child: Text(message),),
            Container(
                margin: const EdgeInsets.only(top: 40),
                child: const FadeAnimation(
                  2,
                  Text(
                    "Udom",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                )),
            Expanded(
              child: Container(
                  width: double.infinity,
                  decoration:  BoxDecoration(
                      color: log_page,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  margin: const EdgeInsets.only(top: 60),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                            // color: Colors.red,
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(left: 22, bottom: 20),
                            child:  FadeAnimation(
                              2,
                              Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 35,
                                    color: log_txt,
                                    letterSpacing: 2,
                                    fontFamily: "Lobster"),
                              ),
                            )),
                        FadeAnimation(
                          2,
                          Container(
                              width: double.infinity,
                              height: 70,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: appbar, width: 1),
                                  boxShadow:  [
                                    BoxShadow(
                                        color: appbar,
                                        blurRadius: 10,
                                        offset: Offset(1, 1)),
                                  ],
                                  color: input,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.email_outlined),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: TextFormField(
                                        controller: username,
                                        maxLines: 1,
                                        decoration: const InputDecoration(
                                          label: Text(" Username ..."),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        FadeAnimation(
                          2,
                          Container(
                              width: double.infinity,
                              height: 70,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: appbar, width: 1),
                                  boxShadow:  [
                                    BoxShadow(
                                        color: appbar,
                                        blurRadius: 10,
                                        offset: Offset(1, 1)),
                                  ],
                                  color: input,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.password_outlined),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: TextFormField(
                                        controller: password,
                                        maxLines: 1,
                                        decoration: const InputDecoration(
                                          label: Text(" Password ..."),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          2,
                          ElevatedButton(
                            onPressed: ()async {
                              var temp_username;
                              var temp_pass;
                              setState(() {
                              attempting=true;
                                temp_username=username.text;
                                temp_pass=password.text;
                              username.text='';
                              password.text='';
                              });
                             
                              if(token==null || token_refresh==null){
                              List<String>? response=await LoginService().login(temp_username, temp_pass);
                             
                               if(response==null){
                                 setState(() {
                                   message="connection problem";
                                   attempting=false;
                                 });
                                }
                                else if(response[0]=='forbidden'){
                                  setState(() {
                                      message="please contact administrator";
                                        attempting=false;
                                  });
                                }
                                else{
                                 
                                  setState(() {
                                  setTokens(response[0], response[1]);
                                  getTokens();
                                  attempting=false;
                                  });
                                 
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateBlog(refresh_token: response[1], token: response[0],),));
                                }
                              }
                              else{

                              }
                               
                              
                            },
                            style: ElevatedButton.styleFrom(
                                onPrimary: appbar,
                                shadowColor: appbar,
                                elevation: 18,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient:  LinearGradient(colors: [
                                    appbar,
                                    appbar2
                                  ]),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                width: 200,
                                height: 50,
                                alignment: Alignment.center,
                                child: attempting==false? const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                ):const CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                   
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}