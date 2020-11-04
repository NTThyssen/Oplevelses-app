import 'package:flutter/material.dart';
import 'package:flutter_app/size_config.dart';

import 'log_in_page.dart';

class NotSignedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(width: SizeConfig.blockSizeHorizontal*100,),
          Spacer(flex: 5,),
          CircleAvatar(
            backgroundImage: AssetImage("images/no-profile-img.jpg"),
            radius: 80,
            ),
          Spacer(flex: 1,),
          Text("You need to be singed in to view this page",
            style: TextStyle(
            color: Colors.white,
              fontSize: 18,
          ),),
          Spacer(flex: 1,),
          RaisedButton(
            color: Theme.of(context).secondaryHeaderColor,
            child: Text("CLICK TO SIGN IN"),
              onPressed: () {
                Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => Login()));
              })
          ,
          Spacer(flex: 5,)
        ],
      ),
    );
  }
}
