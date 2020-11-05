import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/custom_scaffold_with_navBar.dart';
import 'package:flutter_app/size_config.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../../model/user.dart';

class MyFavorites extends StatefulWidget {
  @override
  _MyFavoritesState createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  @override
  Widget build(BuildContext context) {
    MockUser authUser = Provider.of<MockUser>(context);
    final users = Provider.of<List<MockUser>>(context) ?? [];
    for(var user in users ){
      if(user.uid == authUser.uid){
        authUser = user;
      }
    }


    return authUser.favorite != null ?  Scaffold(
        body : SingleChildScrollView(
      child: Column(
        children: [
          FadeIn(
              0.5,
              FavoriteCardView(
                eventUrl: authUser.favorite.event.pictureUrl,
              )),
        ],
      ),
    )) : Center(child: Text("Du har ingen Favoritter"),);
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
  String eventUrl;

  FavoriteCardView({this.eventUrl});

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
                              'Søndags is',
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
                              'med Futte, 23',
                              style: TextStyle(
                                  color: Colors.grey,
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
                              },
                              child: Icon(
                                Icons.favorite,
                                color: Colors.grey,
                                size: 30,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                print("Favorit!");
                              },
                              child: Icon(
                                CupertinoIcons.share,
                                color: Colors.grey,
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
                            image: widget.eventUrl != null
                                ? NetworkImage(widget.eventUrl)
                                : AssetImage('images/big-ice.png'),
                          ),
                        )),
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
