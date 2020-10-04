

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/service/auth.dart';
import 'package:flutter_app/wrapper.dart';
import 'package:provider/provider.dart';
import 'authenticate/log_in_page.dart';
import 'model/user.dart';
import 'size_config.dart';
import 'package:flutter_app/CustomWidgets/custom_scaffold_with_navBar.dart';

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

    count.forEach((element) {
      print(element);
    });



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

                  return  EventDisplay(User("id", name: "nicklas", age:position, profilePicture:"images/flower2.jpg", eventPicture: count.elementAt(position) != null ? count.elementAt(position) : "images/big-ice.png"));
                },
                itemCount: users.documents.length,

              )



                   // EventDisplay(User("id", name:"Caroline", age:23, profilePicture:"images/flower2.jpg", eventPicture:"images/scater-boi.png"))



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
          image: widget.user.eventPicture == "images/big-ice.png" ? AssetImage(widget.user.eventPicture) : NetworkImage(widget.user.eventPicture),
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


