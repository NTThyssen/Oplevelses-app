import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_app/widgets/about_text.dart';
import 'package:flutter_app/widgets/custom_scaffold_with_navBar.dart';
import 'package:flutter_app/widgets/friends_widget.dart';
import 'package:flutter_app/widgets/info_header_widget.dart';
import 'package:flutter_app/widgets/instagram_images_widget.dart';
import 'package:provider/provider.dart';

import '../../model/user.dart';

class Test extends StatefulWidget {
  final String pictureUrl;

  Test({Key key, @required this.pictureUrl}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  int heroTagCounter = 0;

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<User>>(context);
    User currentUser;
    users.forEach((user) {
      heroTagCounter++;

      if (user.event.pictureUrl == widget.pictureUrl) {
        currentUser = user;
        print(currentUser.event.city);
        print(currentUser.event.price.toString() + "price");
        print(currentUser.event.date);
        print(currentUser.event.description);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(currentUser.event.title),
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
                    tag: widget.pictureUrl,
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 60,
                      width: SizeConfig.blockSizeVertical * 100,
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.pictureUrl),
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
                      currentUser.event.title.toString(),
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
                text: currentUser.event.city.toString(),
              ),
              // Date info
              InfoHeaderWidget(
                icon: Icons.access_time,
                text: currentUser.event.date.toString(),
              ),
              // Price info
              InfoHeaderWidget(
                icon: Icons.payment,
                text: currentUser.event.price.toString(),
              ),
              // Event description
              AboutText(
                  heading: 'Oplevelsen',
                  body: currentUser.event.description.toString()),
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
                      onPressed: () {},
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
