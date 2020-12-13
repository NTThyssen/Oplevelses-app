import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/favorite.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/size_config.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../../models/mock_user.dart';

class MyFavorites extends StatefulWidget {
  @override
  _MyFavoritesState createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MockUser authUser = Provider.of<MockUser>(context);

    return FutureBuilder<List<Favorite>>(
        future: DatabaseService().getUserFavoritesFromUid(
            authUser.uid), // a previously-obtained Future<String> or null
        builder:
            (BuildContext context, AsyncSnapshot<List<Favorite>> snapshot) {
          if (snapshot.hasError) {
            print("errrror");
            print(snapshot.error.toString());
          }
          print(snapshot.data);
          if (snapshot.hasData && snapshot.data.isNotEmpty) {
            return snapshot.data.elementAt(0).event != null
                ? Scaffold(
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 80),
                        child: Column(
                          children: snapshot.data
                              .map(
                                (e) => FadeIn(
                                  0.5,
                                  FavoriteCardView(
                                    favorite: e,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Text("Du har ingen favoritter"),
                  );
          } else {
            return Center(
              child: Center(
                child: Text("Du har ingen favoritter"),
              ),
            );
          }
        });
  }
}

enum _AniProps { opacity, translateX }

class FadeIn extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeIn(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_AniProps>()
      ..add(_AniProps.opacity, 0.0.tweenTo(1.0))
      ..add(_AniProps.translateX, 130.0.tweenTo(0.0));

    return PlayAnimation<MultiTweenValues<_AniProps>>(
      delay: (300 * delay).round().milliseconds,
      duration: 500.milliseconds,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(_AniProps.opacity),
        child: Transform.translate(
          offset: Offset(value.get(_AniProps.translateX), 0),
          child: child,
        ),
      ),
    );
  }
}

class FavoriteCardView extends StatefulWidget {
  Favorite favorite;

  FavoriteCardView({this.favorite});

  @override
  _FavoriteCardViewState createState() => _FavoriteCardViewState();
}

class _FavoriteCardViewState extends State<FavoriteCardView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(229, 229, 229, 1),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage('images/flower2.jpg'),
                    ),
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 0, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.favorite.event.title,
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "med person",
                              style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("Favorit!");
                            },
                            child: Icon(
                              Icons.favorite,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.transparent,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 204.5 / 100,
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 25,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        image: new DecorationImage(
                          fit: BoxFit.fitWidth,
                          alignment: FractionalOffset.centerLeft,
                          image: widget.favorite.event.pictureUrl != null
                              ? CachedNetworkImageProvider(
                                  widget.favorite.event.pictureUrl)
                              : AssetImage('images/big-ice.png'),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
