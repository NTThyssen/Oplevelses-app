import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/theme.dart';

class AgeSlider extends StatefulWidget {
  @override
  _AgeSliderState createState() => _AgeSliderState();
}

class _AgeSliderState extends State<AgeSlider> {
  static double _lowerValue = 18.0;
  static double _upperValue = 40.0;
  RangeValues _currentAgeRangeValues = RangeValues(_lowerValue, _upperValue);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
          child: Row(
            children: [
              Text(
                'Alder',
                style: headerTextStyle.copyWith(color: Colors.black),
              ),
              Spacer(),
              Text(
                '${_currentAgeRangeValues.start.round().toString()} - ${_currentAgeRangeValues.end.round().toString()}',
                style: headerTextStyle.copyWith(color: lightGrey),
              ),
            ],
          ),
        ),
        Platform.isIOS
            ? Padding(
                padding: EdgeInsets.all(10),
                child: SliderTheme(
                  data: SliderThemeData(
                    thumbColor: white,
                    trackHeight: 2.0,
                    rangeThumbShape: RoundRangeSliderThumbShape(
                      enabledThumbRadius: 14,
                      pressedElevation: 3,
                      elevation: 3,
                    ),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 10),
                    inactiveTrackColor: Colors.grey[300],
                    activeTrackColor: Colors.blue[300],
                  ),
                  child: RangeSlider(
                    values: _currentAgeRangeValues,
                    min: _lowerValue,
                    max: _upperValue,
                    onChanged: (newRange) {
                      setState(() => _currentAgeRangeValues = newRange);
                    },
                  ),
                ),
              )
            : RangeSlider(
                values: _currentAgeRangeValues,
                min: _lowerValue,
                max: _upperValue,
                onChanged: (newRange) {
                  setState(() => _currentAgeRangeValues = newRange);
                },
              ),
      ],
    );
  }
}
