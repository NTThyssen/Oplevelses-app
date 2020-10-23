import 'package:firebase_core/firebase_core.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/service/auth.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_app/theme.dart';
import 'package:flutter_app/widgets/pop_up_menu.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'screens/home/event_details.dart';
import 'model/user.dart';
import 'widgets/custom_scaffold_with_navBar.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
        providers: [
          StreamProvider<List<MockUser>>.value(
            value: DatabaseService().users,
            child: MyApp(),
          ),
          StreamProvider<MockUser>.value(
              value: AuthService().user, child: MyApp()),
        ],
        child: MaterialApp(
            theme: ThemeData(
              primaryColor: Color.fromRGBO(29, 33, 57, 1),
              secondaryHeaderColor: Color.fromRGBO(131, 199, 242, 1),
            ),
            home: MyApp())),
  );

  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  } else {
    // Handle Crashlytics enabled status when not in Debug,
    // e.g. allow your users to opt-in to crash reporting.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

List<PopUpItem> choices = <PopUpItem>[
  PopUpItem(title: 'Rediger'),
  PopUpItem(title: 'Indstillinger'),
];

class _MyAppState extends State<MyApp> {
  PopUpItem selectedItem = choices[0];

  void _select(PopUpItem item) {
    setState(() {
      selectedItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffoldWithNavBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: "Title",
      icons: [
        PopupMenuButton<PopUpItem>(
          onCanceled: () {
            print('On cancelled was called');
          },
          onSelected: _select,
          itemBuilder: (BuildContext context) {
            return choices.map((PopUpItem choice) {
              return PopupMenuItem<PopUpItem>(
                value: choice,
                child: Text(choice.title),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var isLoading = false;
  var items = 5;
  bool isLiked = false;
  final FlareControls flareControls = FlareControls();
  Widget build(BuildContext context) {
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

    final users = Provider.of<List<MockUser>>(context) ?? [];
    final authUser = Provider.of<MockUser>(context);

    List count = new List();
    var cnt = 0;
    if (users != null) {
      for (var doc in users) {
        if (doc.uid != authUser.uid) {
          print(doc.uid);
          if (cnt < 1) {
            count.add("images/big-ice.png");
            count.add(doc.event.pictureUrl);
            //preload(context, doc.event.pictureUrl);
            cnt++;
          }
        }
      }
    }

    return isLoading
        ? Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            height: SizeConfig.blockSizeVertical * 100,
            color: Theme.of(context).secondaryHeaderColor,
            child: Center(
              child: SpinKitCubeGrid(
                color: Colors.white,
                size: 80.0,
              ),
            ))
        : Container(
            child: Stack(
              children: [
                PreloadPageView.builder(
                  itemCount: users.length,
                  preloadPagesCount: 5,
                  onPageChanged: (index) {
                    if (index == items - 1) {
                      print("last page");
                      setState(() {});
                      print(index);
                    }
                  },
                  itemBuilder: (BuildContext context, int position) {
                    for (var i = 0; i < users.length; i++) {
                      return GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            isLiked = true;
                            flareControls.play("like");
                            authUser.favorite = Favorite();
                            authUser.favorite.event =
                                users.elementAt(position).event;
                            DatabaseService(uid: authUser.uid)
                                .updateUserData(authUser);
                          });
                        },
                        onTap: () {
                          Navigator.push(
                              context,
                              FadeRoute(
                                  page: Test(
                                      pictureUrl: count.elementAt(position))));
                        },
                        child: EventDisplay(
                            MockUser(
                                uid: 'id',
                                name: "nicklas",
                                profilePicture: "images/flower2.jpg",
                                imageURL: count.elementAt(position) != null
                                    ? count.elementAt(position)
                                    : "images/big-ice.png"),
                            flareControls),
                      );
                    }
                    ;
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
            ),
          );
  }
}

class EventDisplay extends StatefulWidget {
  final MockUser user;
  final FlareControls flareControls;
  EventDisplay(this.user, this.flareControls);

  @override
  _EventDisplayState createState() => _EventDisplayState();
}

class _EventDisplayState extends State<EventDisplay> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.user.imageURL,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: widget.user.imageURL == "images/big-ice.png"
                ? AssetImage(widget.user.imageURL)
                : NetworkImage(widget.user.imageURL),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 0, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: AssetImage(widget.user.profilePicture),
                    ),
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 0, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.user.name +
                                  " " +
                                  (widget.user.age?.toString() ?? "23"),
                              style: subtitleTextStyle,
                            ),
                            Text(
                              'Aktivitet 5km væk',
                              style: smallHeaderTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print("Favorit!");
                                widget.flareControls.play("like");
                              },
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
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
