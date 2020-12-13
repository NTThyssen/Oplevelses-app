import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/route_manager.dart' as router;
import 'package:flutter_app/screens/main_menu/menu_overview.dart';
import 'package:flutter_app/screens/settings/profile.dart';
import 'package:provider/provider.dart';

import 'authenticate/not_signed_in.dart';
import 'models/user.dart';

class Wrapper extends StatelessWidget {
  final String route;
  Wrapper({this.route});

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<MockUser>(context);
    Widget widget;
    switch (route) {
      case router.ProfileRoute:
        return widget = authUser != null ? Profile() : NotSignedIn();
      case router.MenuOverviewRoute:
        return widget = authUser != null
            ? MenuOverview()
            : NotSignedIn(
                isPage: false,
              );
      default:
        return widget;
    }
  }
}
