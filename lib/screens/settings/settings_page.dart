import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/route_manager.dart' as router;
import 'package:flutter_app/widgets/age_slider.dart';
import 'package:flutter_app/widgets/category_grid.dart';
import 'package:flutter_app/mixins/basic_mixin.dart';
import 'package:flutter_app/widgets/distance_slider.dart';
import 'package:flutter_app/widgets/navigation_button.dart';

import '../../theme.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with BasicMixin {
  bool _selectAll = false;
  bool _allowNotifications = false;

  @override
  Widget appBar() {
    return AppBar(
      title: Text("Indstillinger"),
    );
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Profile button
          NavigationButton(
            icon: Icons.person_outline,
            text: 'Profil',
            onPressed: () {
              Navigator.pushNamed(context, router.ProfileRoute);
            },
          ),
          Divider(),
          // Notifications options
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
            child: Row(
              children: [
                // Profile navigation button
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
                Text(
                  "Slå notifikationer til/fra",
                  style: headerTextStyle.copyWith(color: Colors.black),
                ),
                Spacer(),
                Switch.adaptive(
                  value: _allowNotifications,
                  activeColor: blue,
                  onChanged: (value) {
                    setState(() {
                      _allowNotifications = !_allowNotifications;
                    });
                  },
                ),
              ],
            ),
          ),
          // Slider divider
          Container(
            color: Colors.grey[200],
            height: 31,
            width: double.infinity,
            child: Center(
              child: Text(
                'Alder og distance',
                style: headerTextStyle.copyWith(color: lightGrey),
              ),
            ),
          ),
          // Age slider
          AgeSlider(),
          Divider(),
          // Distance slider
          DistanceSlider(),
          // Activity divider
          Container(
            color: Colors.grey[200],
            height: 31,
            width: double.infinity,
            child: Center(
              child: Text(
                'Aktiviteter',
                style: headerTextStyle.copyWith(color: lightGrey),
              ),
            ),
          ),
          // Select all activity filters option
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
            child: Row(
              children: [
                Text(
                  'Se alle aktiviteter',
                  style: headerTextStyle.copyWith(color: Colors.black),
                ),
                Spacer(),
                Switch.adaptive(
                  activeColor: blue,
                  value: _selectAll,
                  onChanged: (value) {
                    setState(() {
                      _selectAll = !_selectAll;
                    });
                  },
                ),
              ],
            ),
          ),
          Divider(),
          // Category filter buttons
          CategoryGrid(
            selectAll: _selectAll,
          ),
        ],
      ),
    );
  }
}
