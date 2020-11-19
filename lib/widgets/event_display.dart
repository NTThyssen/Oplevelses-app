
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/service/auth.dart';

import '../size_config.dart';
import '../theme.dart';

class EventDisplay extends StatefulWidget {
  final Event event;
  final FlareControls flareControls;
  EventDisplay(this.event, this.flareControls);

  @override
  _EventDisplayState createState() => _EventDisplayState();
}

class _EventDisplayState extends State<EventDisplay> {
  AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: widget.event.pictureUrl == "images/big-ice.png"
              ? AssetImage(widget.event.pictureUrl)
              : NetworkImage(widget.event.pictureUrl),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: SizeConfig.blockSizeVertical*10,
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 15, 0, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: widget.event.uid,
                    child: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: AssetImage("images/flower2.jpg"),
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
                            " " + (widget.event.price?.toString() ?? "23"),
                            style: subtitleTextStyle,
                          ),
                          Text(
                            'Aktivitet 5km væk',
                            style: smallGreyHeaderTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex : 2,
                      child: IconButton(icon: Icon(Icons.favorite_border, color: Colors.white,), onPressed: () {auth.signOut();} )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}