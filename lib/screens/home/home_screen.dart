import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_app/widgets/custom_scaffold_with_navBar.dart';
import 'package:flutter_app/widgets/event_display.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import '../../theme.dart';
import 'event_details.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var isLoading = true;
  var items = 5;
  bool isLiked = false;
  MockUser user;
  bool initPreload = true;
  final FlareControls flareControls = FlareControls();



  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<MockUser>(context);
    final events = Provider.of<List<Event>>(context) ?? [];
    List<Event> eventList = new List();

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

    if (events != null) {
      for (var doc in events) {
        if (doc.userUid != authUser?.uid ?? 1 ) {
            eventList.add(doc);
            DatabaseService().getUserFromUid(doc.userUid).then((value) {
              doc.user = value;
            });
        }
      }

    }
  isLoading=false;
    return isLoading ? Container(
      width: SizeConfig.blockSizeHorizontal*100,
      height:  SizeConfig.blockSizeVertical*100,
      color: appTheme.accentColor,
      child: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    ) : Stack(
      children: [
        PreloadPageView.builder(
          itemCount: eventList.length,
          preloadPagesCount: 5,
          onPageChanged: (index) {
            if (index == items - 1) {
              print("last page");
              print(index);
            }
          },
          // ignore: missing_return
          itemBuilder: (BuildContext context, int position) {
            for (var i = 0; i < eventList.length; i++) {
              return GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    isLiked = true;
                    flareControls.play("like");
                    authUser.favorite = Favorite();
                    authUser.favorite.event =
                        eventList.elementAt(position);
                    authUser.favorite.userUid = eventList.elementAt(position).uid;
                    DatabaseService(uid: authUser.uid)
                        .updateUserData(authUser);
                  });
                },
                onTap: () {
                  Navigator.push(
                      context,
                      FadeRoute(
                          page: Test(
                              event: eventList.elementAt(position))));
                },
                child: EventDisplay(
                    eventList.elementAt(position), flareControls),
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
