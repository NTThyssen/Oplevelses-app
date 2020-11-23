import 'dart:io';

import 'package:flutter/material.dart';

import '../theme.dart';

class DistanceSlider extends StatefulWidget {
  @override
  _DistanceSliderState createState() => _DistanceSliderState();
}

class _DistanceSliderState extends State<DistanceSlider> {
  double _currentDistanceSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
          child: Row(
            children: [
              Text(
                'Aktivitet inden for',
                style: headerTextStyle.copyWith(color: Colors.black),
              ),
              Spacer(),
              Text(
                '${_currentDistanceSliderValue.round().toString()} km',
                style: headerTextStyle.copyWith(color: lightGrey),
              ),
            ],
          ),
        ),
        Platform.isIOS
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: SliderTheme(
                  data: SliderThemeData(
                    thumbColor: white,
                    trackHeight: 2.0,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 14,
                      pressedElevation: 3,
                      elevation: 3,
                    ),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 10),
                    inactiveTrackColor: Colors.grey[300],
                    activeTrackColor: Colors.blue[300],
                  ),
                  child: Slider(
                    value: _currentDistanceSliderValue,
                    min: 0,
                    max: 100,
                    onChanged: (value) {
                      setState(() => _currentDistanceSliderValue = value);
                    },
                  ),
                ),
              )
            : Padding(
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
    );
  }
}
