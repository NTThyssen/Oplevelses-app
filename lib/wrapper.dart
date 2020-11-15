import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/route_manager.dart' as router;
import 'package:flutter_app/screens/home/home_screen.dart';
import 'package:flutter_app/screens/main_menu/add_event.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/screens/main_menu/my_favorites.dart';
import 'package:flutter_app/screens/settings/profile.dart';
import 'package:flutter_app/screens/settings/settings_page.dart';
import 'package:provider/provider.dart';

import 'authenticate/not_signed_in.dart';
import 'model/user.dart';

class Wrapper extends StatelessWidget {
  final String route;
  Wrapper({this.route});

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<MockUser>(context);
    Widget widget;
    switch (route) {
      case router.ProfileRoute:
        return widget = authUser != null ? Profile() :  NotSignedIn();
      case router.MenuOverviewRoute:
        return widget = authUser != null ? MenuOverview() : NotSignedIn();
      default:
        return widget;
    }

  }
}
