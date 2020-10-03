import 'package:flutter/material.dart';

class InfoHeaderWidget extends StatelessWidget {
  InfoHeaderWidget({this.icon, this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 11, bottom: 12),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ],
      ),
    );
  }
}
