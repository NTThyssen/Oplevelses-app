import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/event.dart';
import 'package:flutter_app/screens/main_menu/add_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_app/widgets/about_text.dart';
import 'package:flutter_app/mixins/basic_mixin.dart';
import 'package:flutter_app/widgets/info_header_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/navigation/route_manager.dart' as router;

import '../../models/mock_user.dart';
import '../../theme.dart';

class Test extends StatefulWidget {
  final Event event;

  Test({Key key, @required this.event}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    final authUser = Provider.of<MockUser>(context);

    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(widget.event.title),
        actions: [
          Icon(Icons.favorite_outline),
        ],
        centerTitle: true,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            SingleChildScrollView(
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
                            image: widget.event?.user?.profilePicture != null
                                ? CachedNetworkImageProvider(
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
                    child: Text(
                      "${widget.event.title} med ${widget.event.user.name}, ${widget.event.user.age}",
                      style: titleTextStyle,
                    ),
                  ),
                  // Place info
                  InfoHeaderWidget(
                    icon: Icons.place_outlined,
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
                    heading: 'Om',
                    body: widget.event?.user?.description ??
                        'Typen der altid løber efter bussen, og altid ender med at komme i alt for god tid.',
                  ),
                  // Common friends
                  //FriendsWidget(text: 'Fælles venner',),
                  // Instagram
                  //InstagramImagesWidget(),
                  // Bottom icons

                  Container(
                    height: SizeConfig.blockSizeVertical * 16,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 0, 0, SizeConfig.blockSizeVertical * 7),
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        authUser == null
                            ? Navigator.pushNamed(
                                context, router.NotSignedInRoute)
                            : Navigator.push(
                                context,
                                FadeRoute(
                                    page: AddOrRepostEvent(
                                  event: widget.event,
                                )));
                      },
                      heroTag: null,
                      child: Icon(
                        Icons.repeat,
                        color: white,
                        size: 40.0,
                      ),
                    ),
                    FloatingActionButton(
                      heroTag: null,
                      child: Icon(
                        Icons.add_box,
                        color: white,
                        size: 40.0,
                      ),
                      onPressed: () async {
                        if (authUser == null) {
                          Navigator.pushNamed(context, router.NotSignedInRoute);
                        } else {
                          dynamic result = await DatabaseService()
                              .sendEventRequest(widget.event.uid,
                                  widget.event.userUid, authUser.uid);
                          key.currentState.showSnackBar(
                              SnackBar(content: Text("Anmodning Sendt")));
                          print("eventRequest sent: {$result}");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
