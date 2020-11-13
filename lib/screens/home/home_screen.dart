import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/widgets/custom_scaffold_with_navBar.dart';
import 'package:flutter_app/widgets/event_display.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'event_details.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var isLoading = false;
  var items = 5;
  bool isLiked = false;
  MockUser user;

  final FlareControls flareControls = FlareControls();


  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<MockUser>(context);
    final events = Provider.of<List<Event>>(context) ?? [];
    List<Event> count = new List();

    void preload(BuildContext context, String path) {
      if (path != null) {
        print(path);
        var configuration = createLocalImageConfiguration(context);
        var _image = NetworkImage(path)..resolve(configuration);
        _image.resolve(ImageConfiguration()).addListener(
          ImageStreamListener(
                (info, call) {
              print(info.image);
              setState(() {});
              print('Networkimage is fully loaded and saved');
              isLoading = false;
              // do something
            },
          ),
        );
      }
    }

    var cnt = 0;
    if (events != null) {
      for (var doc in events) {
        if (doc.userUid != authUser?.uid ?? 1 ) {

          if (cnt < 5) {
            count.add(doc);
            //preload(context, doc.pictureUrl);
            cnt++;
          }
        }
      }
    }
    return Stack(
      children: [
        PreloadPageView.builder(
          itemCount: count.length,
          preloadPagesCount: 5,
          onPageChanged: (index) {
            if (index == items - 1) {
              print("last page");
              setState(() {});
              print(index);
            }
          },
          // ignore: missing_return
          itemBuilder: (BuildContext context, int position) {
            for (var i = 0; i < count.length; i++) {
              return GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    isLiked = true;
                    flareControls.play("like");
                    authUser.favorite = Favorite();
                    authUser.favorite.event =
                        count.elementAt(position);
                    authUser.favorite.userUid = count.elementAt(position).uid;
                    DatabaseService(uid: authUser.uid)
                        .updateUserData(authUser);
                  });
                },
                onTap: () {
                  Navigator.push(
                      context,
                      FadeRoute(
                          page: Test(
                              uid: count.elementAt(position).uid)));
                },
                child: EventDisplay(
                    Event(
                        uid: count.elementAt(position).uid,
                        pictureUrl: count.elementAt(position).pictureUrl != null
                            ? count.elementAt(position).pictureUrl
                            : "images/big-ice.png"),
                    flareControls),
              );
            }
          },
          controller: PreloadPageController(),
        ),
        IgnorePointer(
          child: Center(
            child: SizedBox(
              width: 180,
              height: 180,
              child: FlareActor(
                'images/instagram_like.flr',
                controller: flareControls,
                animation: 'idle',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
