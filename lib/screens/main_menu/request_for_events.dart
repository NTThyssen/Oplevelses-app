import 'package:flutter/material.dart';
import 'package:flutter_app/mixins/basic_mixin.dart';
import 'package:flutter_app/models/event.dart';
import 'package:flutter_app/models/event_request.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/screens/main_menu/my_favorites.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/widgets/event_request_widget.dart';
import 'package:provider/provider.dart';

class RequestForEvents extends StatefulWidget {
  @override
  _RequestForEventsState createState() => _RequestForEventsState();
}

class _RequestForEventsState extends State<RequestForEvents> with BasicMixin {
  List<EventRequest> requests = List();
  List<Future<Event>> eventsFutures = List();
  List<Future> fut = List();
  double fadeTick = 0.3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifikationer"),
      ),
      body: body(context: context),
    );
  }

  @override
  Widget body({BuildContext context}) {
    final authUser = Provider.of<MockUser>(context);
    return StreamBuilder<List<EventRequest>>(
      stream: DatabaseService().getEventRequests(authUser.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          for (var index in snapshot.data) {
            eventsFutures
                .add(DatabaseService().getEventFromUid(index.eventUid));
          }
        }
        return FutureBuilder<List<Event>>(
          future: Future.wait(eventsFutures),
          builder: (context, AsyncSnapshot<List<Event>> snapshot) {
            if (snapshot.hasData) {}
            return snapshot.hasData
                ? Column(
                    children: [
                      for (var ele in snapshot.data)
                        FadeIn(
                          fadeTick += 0.4,
                          EventRequestWidget(
                            eventTitle: ele.title,
                          ),
                        ),
                    ],
                  )
                : Center(
                    child: Container(
                      child: Text("Du har ingen anmodninger"),
                    ),
                  );
          },
        );
      },
    );
  }
}
