import 'package:flutter/material.dart';
import 'package:flutter_app/my_favorites.dart';
import 'package:flutter_app/profile.dart';

import '../main.dart';


class CustomScaffoldWithNavBar extends StatefulWidget {
  final Container body;
  final bool extendBody;
  final String title;

  CustomScaffoldWithNavBar(this.body, {this.extendBody, this.title});


  @override
  _CustomScaffoldWithNavBarState createState() => _CustomScaffoldWithNavBarState();
}


class _CustomScaffoldWithNavBarState extends State<CustomScaffoldWithNavBar> {
  final Map<String, IconData> iconMapping = {
    'left': Icons.filter_list,
    'middle': Icons.add,
    'right': Icons.account_circle,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title ?? ""),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(29, 33, 57, 0.7),
          leading: IconButton(
            icon: Icon(
              Icons.filter_list,
            ),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        extendBody: widget.extendBody ?? false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () { },
          child: Icon(Icons.add),
          elevation: 2.0,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children:[
                IconButton(icon: Icon(Icons.home_outlined, color: Colors.white,), iconSize: 30, onPressed: () {
                  Navigator.pushReplacement(context, FadeRoute( page: MyApp()));}),
                Spacer(flex: 2,),
                IconButton(icon: Icon(Icons.message_outlined, color: Colors.white,), iconSize: 30, onPressed: () {
                  Navigator.pushReplacement(context, FadeRoute( page: Profile())); }),
                Spacer(flex: 8),
                IconButton(icon: Icon(Icons.favorite_border, color: Colors.white,), iconSize: 30, onPressed: () {Navigator.pushReplacement(context, FadeRoute( page: MyFavorites())); }),
                Spacer(flex: 2,),
                IconButton(icon: Icon(Icons.person_outline, color: Colors.white,), iconSize: 30, onPressed: () {Navigator.pushReplacement(context, FadeRoute( page: Profile())); }),
              ],
            ),
          ),
          shape: CircularNotchedRectangle(),
          notchMargin: 4,
          color: Theme.of(context).primaryColor,
        ),
        body: widget.body
    );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}

class SlideLeftRoute extends PageRouteBuilder {
  final Widget page;
  SlideLeftRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}



class SizeRoute extends PageRouteBuilder {
  final Widget page;
  SizeRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        Align(
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        ),
  );
}