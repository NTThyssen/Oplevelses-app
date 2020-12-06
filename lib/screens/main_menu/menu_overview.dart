import 'package:flutter/material.dart';
import 'package:flutter_app/mixins/basic_mixin.dart';
import 'package:flutter_app/navigation/route_manager.dart' as router;
import 'package:flutter_app/screens/main_menu/add_event.dart';
import 'package:flutter_app/screens/main_menu/my_favorites.dart';

import '../../size_config.dart';
import '../../theme.dart';

class MenuOverview extends StatefulWidget {
  @override
  _MenuOverviewState createState() => _MenuOverviewState();
}

class _MenuOverviewState extends State<MenuOverview> with BasicMixin {
  bool isFavorite = false;

  @override
  Widget appBar() {
    return AppBar(
        backgroundColor: Color.fromRGBO(30, 30, 60, 1),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(this.context, router.EventRequestRoute);
              },
              child: Icon(Icons.notifications_none),
            ),
          ),
        ],
        title: Container(
          width: SizeConfig.blockSizeHorizontal * 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = false;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(9),
                            topLeft: Radius.circular(9)),
                        border: Border.all(color: Colors.blue),
                        color: isFavorite == false
                            ? Colors.blue
                            : Colors.transparent),
                    child: Icon(Icons.messenger_outline),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = true;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(9),
                            bottomRight: Radius.circular(9)),
                        border: Border.all(color: Colors.blue),
                        color: isFavorite == false
                            ? Colors.transparent
                            : Colors.blue),
                    child: Icon(Icons.favorite),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget body() {
    return isFavorite
        ? MyFavorites()
        : Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            height: SizeConfig.blockSizeVertical * 100,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    "Ingen beskeder",
                    style: TextStyle(color: Colors.grey, fontSize: 30),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: SizedBox(
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Nyt Event",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          color: blue,
                          onPressed: () {
                            Navigator.push(
                              this.context,
                              FadeRoute(
                                page: AddOrRepostEvent(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
