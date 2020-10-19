import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/category_card.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';

class SettingsPage extends StatefulWidget {
  bool selectAll = false;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _currentAgeRangeValues = RangeValues(18, 40);
  double _currentDistanceSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FlatButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 15),
              child: Row(
                children: [
                  // Profile navigation button
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.person_outline,
                      color: Colors.grey[400],
                      size: 30,
                    ),
                  ),
                  Text(
                    'Profil',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
          Divider(
            indent: 18,
            endIndent: 18,
          ),
          // Age filtering
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      'Alder',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${_currentAgeRangeValues.start.round().toString()} - ${_currentAgeRangeValues.end.round().toString()}',
                      style: TextStyle(
                          color: Colors.grey[400], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              RangeSlider(
                values: _currentAgeRangeValues,
                min: 18.0,
                max: 40.0,
                onChanged: (newRange) {
                  setState(() => _currentAgeRangeValues = newRange);
                },
              ),
            ],
          ),
          Divider(
            indent: 18,
            endIndent: 18,
          ),
          // Distance filtering
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      'Aktivitet inden for',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${_currentDistanceSliderValue.round().toString()} km',
                      style: TextStyle(
                          color: Colors.grey[400], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Slider(
                  value: _currentDistanceSliderValue,
                  min: 0,
                  max: 100,
                  onChanged: (value) {
                    setState(() => _currentDistanceSliderValue = value);
                  },
                ),
              ),
            ],
          ),
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
                PlatformWidget(
                  cupertino: (_, __) => CupertinoSwitch(
                    value: widget.selectAll,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() {
                        widget.selectAll = !widget.selectAll;
                      });
                    },
                  ),
                  material: (_, __) => Switch(
                    value: widget.selectAll,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() {
                        widget.selectAll = !widget.selectAll;
                        if (widget.selectAll) {
                          // Make all cards selected
                        } else {
                          // Unselect all
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          // Activity filter buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 130),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CategoryCard(
                      image: 'images/bicycle.svg',
                      text: 'Motion',
                    ),
                    CategoryCard(
                      image: 'images/popcorn.svg',
                      text: 'Underholdning',
                    ),
                    CategoryCard(
                      image: 'images/food.svg',
                      text: 'Mad og drikke',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CategoryCard(
                      image: 'images/speaker.svg',
                      text: 'Musik og natteliv',
                    ),
                    CategoryCard(
                      image: 'images/museum.svg',
                      text: 'Kultur',
                    ),
                    CategoryCard(
                      image: 'images/open-book.svg',
                      text: 'Bliv klogere',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CategoryCard(
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
