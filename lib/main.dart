import 'package:flutter/material.dart';
import 'package:flutter_app/edit_profile.dart';
import 'package:flutter_app/service/auth.dart';
import 'event_details.dart';
import 'profile.dart';
import 'size_config.dart';
import 'authenticate/log_in_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/my_favorites.dart';
import 'widgets/custom_scaffold_with_navBar.dart';

void main() {
  runApp(StreamProvider.value(
    child: MaterialApp(
      theme: ThemeData(
          primaryColor: Color.fromRGBO(29, 33, 57, 1),
          secondaryHeaderColor: Color.fromRGBO(131, 199, 242, 1),
          accentColor: Color.fromRGBO(131, 199, 242, 1)),
      initialRoute: '/login',
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
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            print("Favorit!");
                                          },
                                          child: Icon(
                                            Icons.favorite_border,
                                            color: Colors.white,
                                            size: 30,
                                          ),
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
            ],
          ),
        ),
      ),
      extendBody: true,
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
