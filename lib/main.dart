

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/service/auth.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_app/wrapper.dart';
import 'package:provider/provider.dart';
import 'authenticate/log_in_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/my_favorites.dart';
import 'model/user.dart';
import 'widgets/custom_scaffold_with_navBar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(StreamProvider<QuerySnapshot>.value(value: DatabaseService().users, child: MaterialApp(
    theme: ThemeData(
      primaryColor: Color.fromRGBO(29, 33, 57, 1),
      secondaryHeaderColor: Color.fromRGBO(131, 199, 242, 1),
    ),

      home: MyApp()
  )));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  MainPage();
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    dynamic users = Provider.of<QuerySnapshot>(context);
    List count = new List();
    var cnt = 0;
    for(var doc in users.documents){
      count.add(doc.data["eventPicture"]);

    }


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
              PageView.builder(
                itemBuilder: (context, position) {

                  return  EventDisplay(User(uid: 'id', name: "nicklas",  profilePicture:"images/flower2.jpg", imageURL: count.elementAt(position) != null ? count.elementAt(position) : "images/big-ice.png"));
                },
                itemCount: users.documents.length,
              )
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
          image: widget.user.imageURL == "images/big-ice.png" ? AssetImage(widget.user.imageURL) : NetworkImage(widget.user.imageURL),
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
                          widget.user.name + " " + (widget.user.age?.toString()  ?? "23" ),
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

