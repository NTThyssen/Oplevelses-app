import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/edit_profile.dart';
import 'package:flutter_app/my_favorites.dart';
import 'event_details.dart';
import 'model/user.dart';
import 'profile.dart';
import 'size_config.dart';
import 'authenticate/log_in_page.dart';
import 'package:provider/provider.dart';
import 'CustomWidgets/custom_scaffold_with_navBar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
void main() {
  runApp(StreamProvider.value(
    child: MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(29, 33, 57, 1),
        secondaryHeaderColor: Color.fromRGBO(131, 199, 242, 1),
      ),
      routes: {
        '/': (context) => MyApp(),
        '/login': (context) => Login(),
        '/event_details': (context) => Test(),
        '/profile': (context) => Profile(),
        '/filter': (context) => Login(),
        '/showProfile': (context) => EditProfile(),
        '/editProfile': (context) => EditProfile(),
        '/favorites': (context) => MyFavorites()
      },
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffoldWithNavBar(
      Container(
        child: GestureDetector(
          onDoubleTap: () {
            Navigator.pushNamed(context, '/favorites');
          },
          onTap: () {
            Navigator.pushNamed(context, '/event_details');
          },
          child: Stack(
            children: [
              PageView(
                children: [
                  EventDisplay(User("Nicklas", 23, "images/flower2.jpg","images/big-ice.png")),
                  EventDisplay(User("Caroline", 23, "images/flower2.jpg", "images/scater-boi.png"))
                  
                ],
              ),
            ],
          ),
        ),
      ),
      extendBody: true,

    );
  }
}

class EventDisplay extends StatefulWidget {

  final User user;
  EventDisplay(this.user);
  
  @override
  _EventDisplayState createState() => _EventDisplayState();
}

class _EventDisplayState extends State<EventDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(widget.user.eventPicture),
        ),
      ),
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
                  AssetImage(widget.user.profilePicture),
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
                          widget.user.name + " " + widget.user.age.toString(),
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
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("Favorit!");
                          },
                          child: Icon(Icons.favorite_border,
                            color: Colors.white, size: 30,),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),);
  }
}


