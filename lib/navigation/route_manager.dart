import 'package:flutter/material.dart';
import 'package:flutter_app/authenticate/log_in_page.dart';
import 'package:flutter_app/authenticate/not_signed_in.dart';
import 'package:flutter_app/screens/home/home_screen.dart';
import 'package:flutter_app/screens/main_menu/request_for_events.dart';
import 'package:flutter_app/screens/settings/settings_page.dart';

import '../main.dart';
import '../wrapper.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RootRoute:
      return MaterialPageRoute(
        builder: (context) {
          return MyApp();
        },
      );

    case HomeScreenRoute:
      return MaterialPageRoute(
        builder: (context) => MainPage(),
      );

    case MenuOverviewRoute:
      return MaterialPageRoute(
        builder: (context) => Wrapper(
          route: MenuOverviewRoute,
        ),
      );

    case SettingsRoute:
      return MaterialPageRoute(
        builder: (context) => SettingsPage(),
      );

    case ProfileRoute:
      return MaterialPageRoute(
        builder: (context) {
          return Wrapper(
            route: ProfileRoute,
          );
        },
      );

    case EventRequestRoute:
      return MaterialPageRoute(
        builder: (context) => RequestForEvents(),
      );

    case SignInRoute:
      return MaterialPageRoute(
        builder: (context) => Login(),
      );

    case NotSignedInRoute:
      return MaterialPageRoute(
        builder: (context) => NotSignedIn(),
      );

    case InitRoute:
      return MaterialPageRoute(
        builder: (context) => InitScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => MainPage(),
      );
  }
}

const String InitRoute = "init";
const String EventRequestRoute = "eventRequest";
const String RootRoute = "root";
const String HomeScreenRoute = "home";
const String ProfileRoute = "profile";
const String MenuOverviewRoute = "menu";
const String SettingsRoute = "settings";
const String SignInRoute = "signIn";
const String NotSignedInRoute = "notSignedIn";
