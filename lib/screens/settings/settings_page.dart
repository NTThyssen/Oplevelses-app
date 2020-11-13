import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/route_manager.dart' as router;

import 'package:flutter_app/screens/settings/profile.dart';
import 'package:flutter_app/widgets/age_slider.dart';
import 'package:flutter_app/widgets/category_grid.dart';
import 'package:flutter_app/widgets/custom_scaffold_with_navBar.dart';
import 'package:flutter_app/widgets/distance_slider.dart';
import 'package:flutter_app/widgets/navigation_button.dart';

import '../../theme.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with BasicMixin {
  bool _selectAll = false;
  bool profileClick = false;

  @override
  Widget body() {
    return SingleChildScrollView(
        child:  Column(
          children: [
            NavigationButton(
              icon: Icons.person_outline,
              text: 'Profil',
              onPressed: () {
               Navigator.pushNamed(context, router.ProfileRoute);
              },
            ),
            NavigationButton(
              icon: Icons.notifications_outlined,
              text: 'Notifikationer',
              onPressed: () {
                // TODO: Navigate to notifications settings
                print('Notifications button pressed');
              },
            ),
            // Age filtering
            AgeSlider(),
            Divider(
              indent: 18,
              endIndent: 18,
            ),
            // Distance filtering
            DistanceSlider(),
            // Activity divider
            Container(
              color: Colors.grey[200],
              height: 31,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Aktiviteter',
                  style: TextStyle(
                    color: lightGrey,
                  ),
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
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
