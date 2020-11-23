import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/authenticate/not_signed_in.dart';
import 'package:flutter_app/screens/main_menu/add_event.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_app/widgets/about_text.dart';
import 'package:flutter_app/widgets/custom_scaffold_with_navBar.dart';
import 'package:flutter_app/widgets/friends_widget.dart';
import 'package:flutter_app/widgets/info_header_widget.dart';
import 'package:flutter_app/widgets/instagram_images_widget.dart';
import 'package:provider/provider.dart';

import '../../model/user.dart';
import '../../theme.dart';

class Test extends StatefulWidget {
  final Event event;

  Test({Key key, @required this.event}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  bool notSignedIn = true;

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    final authUser = Provider.of<MockUser>(context);

    return Scaffold(
        key: key,
        appBar: AppBar(
          title: Text(widget.event.title),
          centerTitle: true,
        ),
        body: notSignedIn
            ? Container(
                color: Theme.of(context).primaryColor,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile image with gradient
                      Stack(
                        children: [
                          Hero(
                            tag: widget.event.uid,
                            child: Container(
                              height: SizeConfig.blockSizeVertical * 60,
                              width: SizeConfig.blockSizeVertical * 100,
                              child: Image(
                                fit: BoxFit.cover,
                                image:
                                    widget.event?.user?.profilePicture != null
                                        ? NetworkImage(
                                            widget.event.user.profilePicture)
                                        : AssetImage("images/flower2.jpg"),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                stops: [0.5, 1.0],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Theme.of(context).secondaryHeaderColor,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Event header
                      Padding(
                        padding: EdgeInsets.all(11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.event.title.toString(),
                              style: titleTextStyle,
                            ),
                            Icon(
                              CupertinoIcons.heart,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                      // Place info
                      InfoHeaderWidget(
                        icon: Icons.place,
                        text: widget.event.city.toString(),
                      ),
                      // Date info
                      InfoHeaderWidget(
                        icon: Icons.access_time,
                        text: widget.event.date.toString(),
                      ),
                      // Price info
                      InfoHeaderWidget(
                        icon: Icons.payment,
                        text: widget.event.price.toString(),
                      ),
                      // Event description
                      AboutText(
                          heading: 'Oplevelsen',
                          body: widget.event.description.toString()),
                      // About event creator section
                      AboutText(
                        heading: 'Om Pia',
                        body:
                            'Typen der altid løber efter bussen, og altid ender med at komme i alt for god tid.',
                      ),
                      // Common friends
                      FriendsWidget(
                        text: 'Fælles venner',
                      ),
                      // Instagram
                      // InstagramImagesWidget(),
                      // Bottom icons
                      Container(
                        padding: EdgeInsets.only(bottom: 40.0, top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: Icon(Icons.repeat),
                              color: Theme.of(context).secondaryHeaderColor,
                              iconSize: 40.0,
                              onPressed: () {
                                authUser == null
                                    ? Navigator.push(
                                        context, FadeRoute(page: NotSignedIn()))
                                    : Navigator.push(
                                        context,
                                        FadeRoute(
                                            page: AddOrRepostEvent(
                                          event: widget.event,
                                        )));
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add_box),
                              color: Theme.of(context).secondaryHeaderColor,
                              iconSize: 40.0,
                              onPressed: () async {
                                if (authUser == null) {
                                  setState(() {
                                    notSignedIn = false;
                                  });
                                } else {
                                  dynamic result = await DatabaseService()
                                      .sendEventRequest(widget.event.uid,
                                          widget.event.userUid, authUser.uid);
                                  key.currentState.showSnackBar(SnackBar(
                                      content: Text("Anmodning Sendt")));
                                  print("eventRequest sent: {$result}");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: SizeConfig.blockSizeVertical * 7,
                      )
                    ],
                  ),
                ),
              )
            : NotSignedIn());
  }
}
