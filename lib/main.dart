import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/category_manager.dart';
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
          StreamProvider<List<Event>>.value(
              value: DatabaseService().events, child: MyApp()),
          ChangeNotifierProvider<CategoryManager>(
              create: (_) => CategoryManager()),
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

    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with BasicMixin {
  var isLoading = false;
  var items = 5;
  bool isLiked = false;
  MockUser user;

  final FlareControls flareControls = FlareControls();
  Widget build(BuildContext context) {
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
        : Scaffold(
            extendBodyBehindAppBar: true,
            appBar: appBar,
            body: body(context: context)
    );
  }

  @override
  Widget appBar = AppBar(
    actions: [IconButton(icon: Icon(Icons.favorite_border, color: Colors.white,), onPressed: () {
      AuthService().signOut();
    })],
    title: Text("Søndags-is"),
    backgroundColor: Colors.transparent,
  );

  @override
  Widget body({BuildContext context}) {
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

          if (cnt < 3) {
            count.add(doc);
            //preload(context, doc.event.pictureUrl);
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
   );
  }
}

class EventDisplay extends StatefulWidget {
  final Event event;
  final FlareControls flareControls;
  EventDisplay(this.event, this.flareControls);

  @override
  _EventDisplayState createState() => _EventDisplayState();
}

class _EventDisplayState extends State<EventDisplay> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.event.uid,
      child: Container(
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
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: AssetImage("images/flower2.jpg"),
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
