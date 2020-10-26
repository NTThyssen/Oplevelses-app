import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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

class Test extends StatefulWidget {
  final String uid;

  Test({Key key, @required this.uid}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {


  @override
  Widget build(BuildContext context) {
    final events = Provider.of<List<Event>>(context);
    final authUser = Provider.of<User>(context);
    Event event;
    events.forEach((e) {

      if (e.uid == widget.uid) {
        event = e;
        print(e.city);
        print(e.price.toString() + "price");
        print(e.date);
        print(e.description);
      }
    });
    User user;


    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        centerTitle: true,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile image with gradient
              Stack(
                children: [
                  Hero(
                    tag: widget.uid,
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 60,
                      width: SizeConfig.blockSizeVertical * 100,
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(event.pictureUrl),
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
                      event.title.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
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
                text: event.city.toString(),
              ),
              // Date info
              InfoHeaderWidget(
                icon: Icons.access_time,
                text: event.date.toString(),
              ),
              // Price info
              InfoHeaderWidget(
                icon: Icons.payment,
                text: event.price.toString(),
              ),
              // Event description
              AboutText(
                  heading: 'Oplevelsen',
                  body: event.description.toString()),
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
              InstagramImagesWidget(),
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
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.add_box),
                      color: Theme.of(context).secondaryHeaderColor,
                      iconSize: 40.0,
                      onPressed: () async {
                       dynamic result = await DatabaseService().sendEventRequest(event.uid, event.userUid, authUser.uid);
                       print("eventRequest sent: " + result);
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
      ),
    );
  }
}
