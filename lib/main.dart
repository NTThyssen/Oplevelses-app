
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/service/auth.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_app/widgets/pop_up_menu.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'event_details.dart';
import 'model/user.dart';
import 'widgets/custom_scaffold_with_navBar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
        providers: [
          StreamProvider<List<User>>.value(
            value: DatabaseService().users,
            child: MyApp(),
          ),
          StreamProvider<User>.value(
              value: AuthService().user, child: MyApp()),
        ],
        child: MaterialApp(
            theme: ThemeData(
              primaryColor: Color.fromRGBO(29, 33, 57, 1),
              secondaryHeaderColor: Color.fromRGBO(131, 199, 242, 1),
            ),
            home: MyApp())),
  );
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
    ],);
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var isLoading = true;
  var items = 4;
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


    final users = Provider.of<List<User>>(context ) ?? [];
    final authUser = Provider.of<User>(context);

    List<User> count = new List();
    var cnt = 0;
    if (users != null) {
      for (var doc in users) {
        if(doc.uid != authUser.uid){
          print(doc.uid);
          if (cnt < 4) {
            count.add(doc);
            preload(context, doc.event.pictureUrl);
            cnt++;
          }
        }
      }
    }
    print(count.length);
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
                    itemCount: count.length,
                    preloadPagesCount: 4,
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
                              authUser.favorite.event = count.elementAt(position).event;
                              DatabaseService(uid: authUser.uid).updateUserData(authUser);
                            });

                          },
                          onTap: () {
                            Navigator.push(
                                context,
                                FadeRoute(
                                    page: Test(
                                        pictureUrl:
                                            count.elementAt(position).event.pictureUrl)));
                          },
                          child: EventDisplay(User(
                              uid: 'id',
                              name: "nicklas",
                              profilePicture: "images/flower2.jpg",
                              imageURL: count.elementAt(position).event.pictureUrl != null
                                  ? count.elementAt(position).event.pictureUrl
                                  : "images/big-ice.png"), flareControls),
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
                  ) ,
                ],
              ),
            );
  }
}

class EventDisplay extends StatefulWidget {
  final User user;
  final  FlareControls flareControls;
  EventDisplay(this.user,  this.flareControls);

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
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              'aktivitet 5km væk',
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.7,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16),
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
