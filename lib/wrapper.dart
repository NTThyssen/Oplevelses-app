import 'package:flutter/material.dart';
import 'package:flutter_app/screens/main_menu/add_event.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/screens/main_menu/my_favorites.dart';
import 'package:flutter_app/screens/settings/profile.dart';
import 'package:flutter_app/screens/settings/settings_page.dart';
import 'package:provider/provider.dart';

import 'authenticate/not_signed_in.dart';
import 'model/user.dart';

class Wrapper extends StatelessWidget {
  final int index;
  Wrapper({this.index});

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<MockUser>(context);
    Widget widget;
    switch (index) {
      case 0:
        widget = MainPage();
        break;
      case 1:
        widget = authUser != null ? MenuOverview() : NotSignedIn();
        break;
      case 2:
        widget = authUser != null ? SettingsPage() : NotSignedIn();
        break;
      default:
        return widget;
    }
    return widget;
  }
}
