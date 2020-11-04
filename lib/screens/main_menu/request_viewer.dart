import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/service/auth.dart';
import 'package:age/age.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_app/widgets/about_text.dart';
import 'package:flutter_app/widgets/friends_widget.dart';
import 'package:flutter_app/widgets/info_header_widget.dart';
import 'package:flutter_app/widgets/instagram_images_widget.dart';
import 'package:provider/provider.dart';


class RequestViewer extends StatefulWidget {
  @override
  _RequestViewerState createState() => _RequestViewerState();
}
class _RequestViewerState extends State<RequestViewer> {
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
  List<Future<MockUser>> eventsFutures = List();
  int counter=0;
  List<MockUser> users = List();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MockUser>(context);
    String name = checkFbData();
    //convertDateFromString(UserLoginState.instance.getProfile()['birthday']);
    return StreamBuilder<List<EventRequest>>(
        stream: DatabaseService().getEventRequests(user.uid),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            for(var index in snapshot.data){
              for(var t in index.userUid){
                eventsFutures.add(DatabaseService().getUserFromUid(t));
              }

            }
          }
      if(snapshot.hasData){
        return FutureBuilder<List<MockUser>>(
            future: Future.wait(eventsFutures),
            builder: (context, AsyncSnapshot<List<MockUser>> snapshot){
              users = snapshot.data;

              return snapshot.hasData ? Container(
                color: Theme
                    .of(context)
                    .primaryColor,
                child: Stack(

                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile image with gradient
                          Stack(
                            children: [
                              Container(
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
                              Container(
                                height: SizeConfig.blockSizeVertical * 70,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    stops: [0.5, 1.0],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Theme
                                          .of(context)
                                          .primaryColor,
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
                                  users.elementAt(0).uid,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
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
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        width: SizeConfig.blockSizeHorizontal * 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                                onTap: () {

                                },
                                child: Icon(Icons.close, size: 60, color: Colors.red)
                            ),
                            Text("Du har ${users.length} anmodninger", style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.none,
                                color: Colors.white
                            ),
                            ),
                            GestureDetector(
                                onTap: () {

                                },
                                child: Icon(
                                  Icons.check, size: 60, color: Colors.green,)
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ) : Center(child:Container(child: Text("Loading"),));

            });
      }else{
        return Container();
      }


      });
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
