import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/category_manager.dart';
import 'package:flutter_app/screens/home/home_screen.dart';
import 'package:flutter_app/screens/main_menu/add_event.dart';
import 'package:flutter_app/screens/settings/settings_page.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/service/auth.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_app/theme.dart';
import 'package:flutter_app/widgets/pop_up_menu.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'screens/home/event_details.dart';
import 'model/user.dart';
import 'widgets/custom_scaffold_with_navBar.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
        providers: [
          StreamProvider<List<MockUser>>.value(
            value: DatabaseService().users,
            child: MyApp(),
          ),
          StreamProvider<MockUser>.value(
              value: AuthService().user, child: MyApp()),
          StreamProvider<List<Event>>.value(
              value: DatabaseService().events, child: MyApp()),
          ChangeNotifierProvider<CategoryManager>(
              create: (_) => CategoryManager()),
        ],
        child: MaterialApp(
          theme: appTheme,
            home: MyApp())),
  );

  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  } else {
    // Handle Crashlytics enabled status when not in Debug,
    // e.g. allow your users to opt-in to crash reporting.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

List<PopUpItem> choices = <PopUpItem>[
  PopUpItem(title: 'Rediger'),
  PopUpItem(title: 'Indstillinger'),
];

class _MyAppState extends State<MyApp> with BasicMixin {
  PopUpItem selectedItem = choices[0];
  int _selectedPage = 0;
  List<Widget> widgetList = [
    MainPage(),
    MenuOverview(),
    SettingsPage()

  ];

  void _select(PopUpItem item) {
    setState(() {
      selectedItem = item;
    });
  }

  @override
  Widget appBar(){
    return AppBar(
      backgroundColor: Colors.transparent,
    );
  }

  @override
  bool extendBody() => true;

  @override
  bool extendBehindAppBar() => true;

  @override
  Widget body() {
    SizeConfig().init(context);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: widgetList.elementAt(_selectedPage),
    );
  }

  @override
  Widget bottomNavigationBar() {

    return ConvexAppBar(
      color: Theme.of(context).secondaryHeaderColor,
      activeColor: Colors.indigo,
      style: TabStyle.fixedCircle,
      initialActiveIndex: _selectedPage,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
      items: [
        TabItem(
          icon: Icons.home,
          title: 'Home',
        ),
        TabItem(
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 50,
          ),
          title: 'Add',
        ),

        TabItem(
          icon: Icons.settings,
          title: 'Instillinger',
        ),
      ],
      onTap: (index) {
        setState(() {
          _selectedPage = index;
        });
      },
    );

  }
}


