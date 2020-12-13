import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/event.dart';
import 'package:flutter_app/models/favorite.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/service/auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../size_config.dart';
import '../theme.dart';

class EventDisplay extends StatefulWidget {
  final Event event;
  final FlareControls flareControls;
  final MockUser currentUser;
  EventDisplay(this.event, this.flareControls, {this.currentUser});

  @override
  _EventDisplayState createState() => _EventDisplayState();
}

class _EventDisplayState extends State<EventDisplay> {
  AuthService auth = AuthService();
  /* Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: widget.event.pictureUrl == null
              ? AssetImage("images/big-ice.png")
              : NetworkImage(widget.event.pictureUrl),
        ),
      ),*/
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MockUser>(
        future: DatabaseService().getUserFromUid(widget.event.userUid),
        builder: (BuildContext context, AsyncSnapshot<MockUser> snapshot) {
          if (snapshot.hasData && widget.event.pictureUrl != null) {
            return Stack(
              children: [
                Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: SizeConfig.blockSizeVertical * 100,
                  child: CachedNetworkImage(
                    imageUrl: widget.event.pictureUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      color: appTheme.accentColor,
                      child: Center(
                        child: SpinKitCubeGrid(
                          color: Colors.white,
                          size: 80.0,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          primaryBlue,
                          Colors.transparent,
                          primaryBlue,
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: widget.event.uid,
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: snapshot.data.profilePicture != null
                              ? CachedNetworkImageProvider(
                                  snapshot.data.profilePicture)
                              : AssetImage("images/flower2.jpg"),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.event.title ?? "ukendt",
                                style: subtitleTextStyle,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  "${snapshot.data.name ?? "ukendt"}, ${snapshot.data.age ?? "ukendt"}",
                                  style: smallGreyHeaderTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 35,
                          ),
                          onPressed: () {
                            widget.flareControls.play("like");
                            widget.currentUser.favorite = Favorite();
                            widget.currentUser.favorite = Favorite(
                                event: widget.event,
                                userUid: widget.event.userUid);
                            DatabaseService(uid: widget.currentUser.uid)
                                .updateUserData(widget.currentUser);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Container(
              child: Text(""),
            );
          }
        });
  }
}
