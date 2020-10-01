import 'package:flutter/material.dart';
import 'package:flutter_app/edit_profile.dart';
import 'package:flutter_app/my_events.dart';
import 'package:flutter_app/service/auth.dart';
import 'event_details.dart';
import 'profile.dart';
import 'size_config.dart';
import 'authenticate/log_in_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(StreamProvider.value(
    child: MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(30, 30, 60, 1),
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => MyApp(),
        '/login': (context) => Login(),
        '/event_details': (context) => Test(),
        '/profile': (context) => Profile(),
        '/filter': (context) => Login(),
        '/showProfile': (context) => EditProfile(),
        '/editProfile': (context) => EditProfile(),
        '/myOverview': (context) => MyOverview()
      },
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Oplevelsesapp'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.filter_list,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
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
                                      onTap: () {},
                                      child: Icon(Icons.share,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print("Favorit!");
                                      },
                                      child: Icon(Icons.favorite_border,
                                          color: Colors.white),
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
                      image: UserLoginState.instance.getProfilePicture() ??
                          AssetImage("images/sexy.jpg"),
                    ),
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          stops: [0.0, 1.0],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Color.fromRGBO(30, 30, 60, 1)
                          ])),
                  child: Padding(
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
    'left': Icons.filter_list,
    'middle': Icons.add,
    'right': Icons.account_circle,
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
          if (iconImg.contains("left")) {
            routeName = "/filter";
          } else if (iconImg.contains("middle")) {
            routeName = "/myOverview";
          } else {
            routeName = "/profile";
          }
          Navigator.pushNamed(context, routeName);
        },
        child: Icon(
          iconMapping[iconImg],
          size: iconSize,
        ),
        backgroundColor: Color.fromRGBO(30, 30, 60, 1),
      ),
    );
  }
}
