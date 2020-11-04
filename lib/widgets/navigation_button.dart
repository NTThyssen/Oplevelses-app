import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  NavigationButton({this.icon, this.text, this.onPressed});

  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
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
                color: Colors.grey[600],
                size: 30,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 20,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}
