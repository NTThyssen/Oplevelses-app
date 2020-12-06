import 'package:flutter/material.dart';

import '../theme.dart';

class InputFormField extends StatefulWidget {
  InputFormField({
    this.initialValue,
    this.labelText,
    this.keyboardType,
    this.maxLines,
    this.width,
    this.height,
    this.validate,
    this.onChanged,
  });
  final Function(String) onChanged;
  final String initialValue;
  final String labelText;
  final TextInputType keyboardType;
  final int maxLines;
  final double width;
  final double height;
  final bool validate;

  @override
  _InputFormFieldState createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: widget.onChanged,
              onEditingComplete: () => widget.labelText == "By"
                  ? FocusScope.of(context).unfocus()
                  : FocusScope.of(context).nextFocus(),
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines,
              maxLength: 180,
              initialValue: widget.initialValue,
              decoration: InputDecoration(
                hintStyle: inputFieldTextStyle,
                border: InputBorder.none,
                labelText: widget.labelText,
                counterText: "",
              ),
            ),
          ),
          width: widget.width,
          height: widget.height,
          margin: EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: widget.validate || widget.labelText == "Pris"
                ? null
                : Border.all(color: Colors.red),
            color: Colors.grey[50],
          ),
        ),
      ),
    );
  }
}
