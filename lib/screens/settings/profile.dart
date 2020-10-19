import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/auth.dart';
import 'package:age/age.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_app/widgets/about_text.dart';
import 'package:flutter_app/widgets/custom_scaffold_with_navBar.dart';
import 'package:flutter_app/widgets/friends_widget.dart';
import 'package:flutter_app/widgets/info_header_widget.dart';
import 'package:flutter_app/widgets/instagram_images_widget.dart';
import 'package:flutter_app/widgets/pop_up_menu.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String checkFbData() {
    String name;
    if (UserLoginState.instance.getProfile() != null) {
      name = UserLoginState.instance.getProfile()['first_name'] +
          ", " +
          convertDateFromString(
                  UserLoginState.instance.getProfile()['birthday'])
              .toString();
    } else {
      name = "Pia, 22";
    }
    print(name);
    return name;
  }

  int convertDateFromString(String strDate) {
    List<String> date = strDate.split("/");
    print(date);
    DateTime birthday = DateTime(
        int.tryParse(date[2]), int.tryParse(date[0]), int.tryParse(date[1]));
    DateTime today = DateTime.now();
    print(birthday);
    AgeDuration age;
    // Find out your age

    age = Age.dateDifference(
        fromDate: birthday, toDate: today, includeToDate: false);
    print(age.years);
    print('Your age is {$age}'); // Your ag
    return age.years;
  }

  @override
  Widget build(BuildContext context) {
    String name = checkFbData();
    //convertDateFromString(UserLoginState.instance.getProfile()['birthday']);
    return Container(
      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile image with gradient
            Stack(
              children: [
                Hero(
                  tag: "profile",
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    height: SizeConfig.blockSizeVertical * 70,
                    child: Image(
                      fit: BoxFit.cover,
                      image: name == "Pia, 22"
                          ? AssetImage("images/pia-profile-pic.jpg")
                          : NetworkImage(
                              UserLoginState.instance.profilePic.url),
                      // UserLoginState.instance.getProfilePicture(),
                    ),
                  ),
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0.5, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Theme.of(context).primaryColor,
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Profile name and age
            Padding(
              padding: EdgeInsets.all(11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            // Home town info
            InfoHeaderWidget(
              icon: Icons.place,
              text: 'København NV',
            ),
            // Work info
            InfoHeaderWidget(
              icon: Icons.work,
              text: 'Fotograf hos Hansens billeder',
            ),
            // School info
            InfoHeaderWidget(
              icon: Icons.school,
              text: 'Dansk fotograf institut',
            ),
            // About person text
            AboutText(
              heading: 'Om Pia',
              body:
                  'Typen der altid løber efter bussen, og altid ender med at komme i alt for god tid.',
            ),
            // Common friends
            FriendsWidget(
              text: 'Venner',
            ),
            // Instagram
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: InstagramImagesWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatefulWidget {
  final String text;
  final IconData menuIcon;
  MenuButton({this.text, this.menuIcon});

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  String route;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: () {
          switch (widget.text) {
            case "Vis Profil":
              route = "/showProfile";
              break;
            case "Rediger":
              route = "/editProfile";
              break;
            case "Indstillinger":
              route = "/settings";
              break;
          }
          Navigator.pushNamed(context, route);
        },
        child: Row(
          children: [
            Icon(widget.menuIcon),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(widget.text,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(color: Colors.white),
    );
  }
}