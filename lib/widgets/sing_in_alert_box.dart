import 'package:flutter/material.dart';
import 'package:flutter_app/authenticate/log_in_page.dart';

import '../mixins/basic_mixin.dart';

class SingInAlertBox extends StatefulWidget {
  String alertTitle;
  String alertContent;
  List<Widget> actions;

  SingInAlertBox({this.alertTitle, this.alertContent, this.actions});

  @override
  _SingInAlertBoxState createState() => _SingInAlertBoxState();
}

class _SingInAlertBoxState extends State<SingInAlertBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.alertTitle ?? "Sign in needed"),
      content: Text(widget.alertContent ?? "Do you want to sing in?"),
      actions: widget.actions ??
          [
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No")),
            FlatButton(
                onPressed: () {
                  Navigator.pushReplacement(context, FadeRoute(page: Login()));
                },
                child: Text("Yes")),
          ],
      elevation: 24.0,
      backgroundColor: Theme.of(context).secondaryHeaderColor,
    );
  }
}
