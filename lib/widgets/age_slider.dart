import 'package:flutter/material.dart';

class AgeSlider extends StatefulWidget {
  @override
  _AgeSliderState createState() => _AgeSliderState();
}

class _AgeSliderState extends State<AgeSlider> {
  var _currentAgeRangeValues = RangeValues(18, 40);

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
    );
  }
}
