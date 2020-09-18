import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return PageView(
        children: [
          Container(
          color: Colors.pink,
          ),
          Container(
            color: Colors.lightBlue
          )
        ],
      );
  }
}
