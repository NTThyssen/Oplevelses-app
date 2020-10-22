import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/age_slider.dart';
import 'package:flutter_app/widgets/distance_slider.dart';
import 'package:flutter_app/widgets/navigation_button.dart';
import 'package:flutter_app/widgets/category_card.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _selectAll = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          NavigationButton(
            icon: Icons.person_outline,
            text: 'Profil',
          ),
          Divider(
            indent: 18,
            endIndent: 18,
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
                  color: Colors.grey[400],
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
                    activeColor: Colors.blue,
                    value: _selectAll,
                    onChanged: (value) {
                      setState(() {
                        _selectAll = !_selectAll;
                      });
                    }),
              ],
            ),
          ),
          Divider(),
          // Category filter buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 130),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CategoryCard(
                      selected: _selectAll,
                      image: 'images/bicycle.svg',
                      text: 'Motion',
                    ),
                    CategoryCard(
                      selected: _selectAll,
                      image: 'images/popcorn.svg',
                      text: 'Underholdning',
                    ),
                    CategoryCard(
                      selected: _selectAll,
                      image: 'images/food.svg',
                      text: 'Mad og drikke',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CategoryCard(
                      selected: _selectAll,
                      image: 'images/speaker.svg',
                      text: 'Musik og natteliv',
                    ),
                    CategoryCard(
                      selected: _selectAll,
                      image: 'images/museum.svg',
                      text: 'Kultur',
                    ),
                    CategoryCard(
                      selected: _selectAll,
                      image: 'images/open-book.svg',
                      text: 'Bliv klogere',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CategoryCard(
                      selected: _selectAll,
                      image: 'images/thumb-up.svg',
                      text: 'Gratis',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
