import 'package:flutter/material.dart';
import 'package:flutter_app/add_event.dart';
import 'package:flutter_app/authenticate/log_in_page.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/my_favorites.dart';
import 'package:flutter_app/profile.dart';
import 'package:flutter_app/service/auth.dart';
import 'package:flutter_app/widgets/sing_in_alert_box.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class CustomScaffoldWithNavBar extends StatefulWidget {
  final Container body;
  final bool extendBody;
  final String title;
  final bool extendUp;
  final List<Widget> icons;
  final Color backgroundColor;

  CustomScaffoldWithNavBar(
      {@required this.body,
      this.extendBody,
      this.title,
      this.extendUp,
      this.icons,
      this.backgroundColor});

  @override
  _CustomScaffoldWithNavBarState createState() =>
      _CustomScaffoldWithNavBarState();
}

class _CustomScaffoldWithNavBarState extends State<CustomScaffoldWithNavBar> {
  final Map<String, IconData> iconMapping = {
    'left': Icons.filter_list,
    'middle': Icons.add,
    'right': Icons.account_circle,
  };

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    final authUser = Provider.of<User>(context);
    final AuthService _auth = new AuthService();

    return Scaffold(
        extendBodyBehindAppBar: widget.extendUp ?? false,
        appBar: AppBar(
            title: Text(widget.title ?? ""),
            centerTitle: true,
            backgroundColor: widget.backgroundColor,
            leading: IconButton(
              icon: Icon(
                Icons.filter_list,
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            actions: widget.icons),
        extendBody: widget.extendBody ?? false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: keyboardIsOpened
            ? null
            : FloatingActionButton(
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                onPressed: () {
                  if (authUser != null) {
                    Navigator.pushReplacement(
                        context, SlideLeftRoute(page: AddEvent()));
                  } else {
                    showDialog(
                      context: context,
                      builder: (e) => SingInAlertBox(),
                    );
                  }
                },
                child: Icon(Icons.add, size: 40),
                elevation: 2.0,
              ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, FadeRoute(page: MainPage()));
                    }),
                Spacer(
                  flex: 2,
                ),
                IconButton(
                    icon: Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      //Navigator.pushReplacement(context, FadeRoute( page: Login()));
                    }),
                Spacer(flex: 8),
                IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      if (authUser != null) {
                        Navigator.pushReplacement(
                            context, FadeRoute(page: MyFavorites()));
                      } else {
                        showDialog(
                          context: context,
                          builder: (e) => SingInAlertBox(),
                        );
                      }
                    }),
                Spacer(
                  flex: 2,
                ),
                IconButton(
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      if (authUser != null) {
                        Navigator.pushReplacement(
                            context, FadeRoute(page: Profile()));
                      } else {
                        showDialog(
                          context: context,
                          builder: (e) => SingInAlertBox(),
                        );
                      }
                    }),
              ],
            ),
          ),
          shape: CircularNotchedRectangle(),
          notchMargin: 4,
          color: Theme.of(context).primaryColor,
        ),
        body: widget.body);
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
