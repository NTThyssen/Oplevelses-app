import 'package:flutter/material.dart';
import 'package:flutter_app/theme.dart';

class NavigationButton extends StatelessWidget {
  NavigationButton({this.icon, this.text, this.onPressed});

  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 15),
        child: Row(
          children: [
            // Profile navigation button
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                icon,
                color: Colors.black,
                size: 25,
              ),
            ),
            Text(
              text,
              style: headerTextStyle.copyWith(color: Colors.black),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
