import 'package:flutter/material.dart';
import 'package:flutter_app/screens/main_menu/request_viewer.dart';

import '../size_config.dart';
import '../mixins/basic_mixin.dart';

class EventRequestWidget extends StatefulWidget {
  final String eventTitle;

  EventRequestWidget({this.eventTitle});

  @override
  _EventRequestWidgetState createState() => _EventRequestWidgetState();
}

class _EventRequestWidgetState extends State<EventRequestWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, FadeRoute(page: RequestViewer()));
          },
          child: Container(
            height: SizeConfig.blockSizeVertical * 15,
            width: SizeConfig.blockSizeHorizontal * 100,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person_outline,
                        color: Theme.of(context).secondaryHeaderColor,
                        size: 35,
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.eventTitle ?? "title",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        Divider(
          thickness: 2,
        )
      ],
    );
  }
}
