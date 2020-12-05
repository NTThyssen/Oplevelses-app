import 'package:flutter/material.dart';

import '../theme.dart';

class InputFormField extends StatelessWidget {
  InputFormField({
    this.initialValue,
    this.value,
    this.labelText,
    this.keyboardType,
    this.maxLines,
    this.width,
    this.height,
  });

  String value;
  final String initialValue;
  final String labelText;
  final TextInputType keyboardType;
  final int maxLines;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: TextFormField(
                onChanged: (input) {
                  value = input;
                },
                onEditingComplete: () {
                  if (labelText == "By") {
                    FocusScope.of(context).unfocus();
                  } else {
                    FocusScope.of(context).nextFocus();
                  }
                },
                keyboardType: keyboardType,
                maxLines: maxLines,
                maxLength: 180,
                initialValue: initialValue,
                decoration: InputDecoration(
                  hintStyle: inputFieldTextStyle,
                  border: InputBorder.none,
                  labelText: labelText,
                  counterText: "",
                ),
              ),
            ),
            width: width,
            height: height,
            margin: const EdgeInsets.only(
                bottom: 6.0), //Same as `blurRadius` i guess
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.grey[50],
            ),
          ),
        ),
      ),
    );
  }
}
