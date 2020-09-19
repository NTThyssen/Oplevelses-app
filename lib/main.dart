import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/edit_profile.dart';
import 'event_details.dart';
import 'profile.dart';
import 'size_config.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'authenticate/log_in_page.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => MyApp(),
      '/event_details': (context) => Test(),
      '/profile': (context) => Profile(),
      '/filter': (context) => Login(),
      '/showProfile': (context) => EditProfile(),
      '/editProfile': (context) => EditProfile(),
    },
  ));
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // This widget is the root of your application.
  void _facebookSignIn() async{
    FacebookLogin facebookLogin = FacebookLogin();

  final result = await facebookLogin.logIn(['email']);
  final token = result.accessToken.token;
  final graphResponse = await http.get(
  'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
  final profile = graphResponse.body;
  print(profile);
    if(result.status == FacebookLoginStatus.loggedIn){
      final creadentials = FacebookAuthProvider.getCredential(accessToken: token);
      _auth.signInWithCredential(creadentials);
    }
}


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/event_details');
        },
        child: Stack(
          children: [
            PageView(
              children: [
                Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 15, 0, 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 25.0,
                                backgroundImage:
                                    AssetImage('images/flower2.jpg'),
                              ),
                              Expanded(
                                flex: 8,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 5, 0, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nicklas 23',
                                        style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 1.0,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        'aktivitet 5km væk',
                                        style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 0.7,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _facebookSignIn();
                                      },
                                      child: Icon(
                                        Icons.share, color: Colors.white
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print("Favorit!");
                                      },
                                      child: Icon(Icons.favorite_border, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          child: Text("we"),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("images/flower.jpg"),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("images/sexy.jpg"),
                    ),
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomFAB(30.0, "left", 50.0, 50.0),
                     CustomFAB(30.0, "middle", 50.0, 50.0),
                      CustomFAB(30.0, "right", 50.0, 50.0)
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomFAB extends StatelessWidget {
  final double iconSize;
  final String iconImg;
  final double width;
  final double height;

  final Map<String, IconData> iconMapping = {
    'left' : Icons.filter_list,
    'middle' : Icons.add,
    'right' : Icons.account_circle,
  };
  CustomFAB(this.iconSize, this.iconImg, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FloatingActionButton(
        heroTag: iconImg,
        onPressed: () {
          String routeName;
          if(iconImg.contains("left")){
            routeName = "/filter";
          }else if(iconImg.contains("middle")){
            routeName = "/add";
          }else{
            routeName = "/profile";
          }
          Navigator.pushNamed(context, routeName);
        },
        child: Icon(iconMapping[iconImg], size: iconSize,),
        backgroundColor: Color.fromRGBO(30, 30, 60, 1),
      ),
    );
  }
}

