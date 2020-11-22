import 'package:flutter/material.dart';
import '../size_config.dart';



mixin BasicMixin<Page extends StatefulWidget> on State<Page> {

  Widget appBar(){
    return null;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
     return Scaffold(
       extendBody: extendBody(),
       extendBodyBehindAppBar: extendBehindAppBar(),
       appBar: appBar(),
       bottomNavigationBar: bottomNavigationBar(),
       body: Container(
         width: MediaQuery.of(context).size.width,
         child: body(),
       ),
     );
  }

  Widget body();

  bool extendBody() => false;

  bool extendBehindAppBar() => false;

  Widget bottomNavigationBar() => null;

  Widget action() => Container();

  Widget titleWidget() {
    return Container();
  }
}

/*class CustomScaffoldWithNavBar extends StatefulWidget {

  @override
  _CustomScaffoldWithNavBarState createState() =>
      _CustomScaffoldWithNavBarState();
}


class _CustomScaffoldWithNavBarState extends State<CustomScaffoldWithNavBar> {
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Container();
  }


}

class BottomAppBarCustom extends StatefulWidget {
  @override
  _BottomAppBarCustomState createState() => _BottomAppBarCustomState();
}

class _BottomAppBarCustomState extends State<BottomAppBarCustom> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
                  /*if (authUser != null) {
                    Navigator.pushReplacement(
                        context, FadeRoute(page: MyFavorites()));
                  } else {
                    showDialog(
                      context: context,
                      builder: (e) => SingInAlertBox(),
                    );
                  }*/
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
                  /*if (authUser != null) {
                    Navigator.pushReplacement(
                        context, FadeRoute(page: Profile()));
                  } else {
                    showDialog(
                      context: context,
                      builder: (e) => SingInAlertBox(),
                    );
                  }*/
                }),
          ],
        ),
      ),
      shape: CircularNotchedRectangle(),
      notchMargin: 4,
      color: Theme.of(context).primaryColor,
    );
  }
}
*/
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
            begin: const Offset(1, 0),
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