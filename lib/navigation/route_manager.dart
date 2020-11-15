import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/screens/home/home_screen.dart';
import 'package:flutter_app/screens/main_menu/add_event.dart';
import 'package:flutter_app/screens/settings/profile.dart';
import 'package:flutter_app/screens/settings/settings_page.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../size_config.dart';
import '../wrapper.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  MockUser authUser;
  switch(settings.name){
    case RootRoute:
      return MaterialPageRoute(builder: (context) {
        return MyApp();
      });
    case HomeScreenRoute:
      return MaterialPageRoute(
          builder: (context) => MainPage());
    case MenuOverviewRoute:
      return MaterialPageRoute(
          builder: (context) => Wrapper(route: MenuOverviewRoute,));
    case SettingsRoute:
      return MaterialPageRoute(
        builder: (context) => SettingsPage());
    case ProfileRoute:
      return MaterialPageRoute(builder: (context) {
        return Wrapper(route: ProfileRoute,);
      });
    default:
      return MaterialPageRoute(builder: (context) => MainPage());
  }

}

const String RootRoute = "root";
const String HomeScreenRoute = "home";
const String ProfileRoute = "profile";
const String MenuOverviewRoute = "menu";
const String SettingsRoute = "settings";