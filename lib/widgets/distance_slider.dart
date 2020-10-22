import 'package:flutter/material.dart';

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
    );
  }
}
