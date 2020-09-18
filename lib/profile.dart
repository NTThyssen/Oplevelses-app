import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(30, 30, 60, 1),
        toolbarHeight: 45,
        title: Text("Profil"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 16),
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/flower2.jpg"),
                  radius: 90,
                ),
              ),
            ),
            Text("Nicklas, 23", style: TextStyle(
                color: Colors.black,
                letterSpacing: 0.8,
                fontWeight: FontWeight.w600,
                fontSize: 20),),

            Divider(
              height: 80,
              thickness: 1.0,
              endIndent: 50.0,
              indent: 50,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: MenuButton("Vis Profil"),
            ),
            Divider(
              height: 1,
              thickness: 1.0,
              endIndent: 10.0,
              indent: 10,
            ),
            MenuButton("Rediger"),
            Divider(
              height: 1,
              thickness: 1.0,
              endIndent: 10.0,
              indent: 10,
            ),
            MenuButton("Indstillinger"),
          ],
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(239, 239, 244, 1),
          ),
        ),
      );
  }
}

class MenuButton extends StatefulWidget {
  final String text;
  MenuButton(this.text);

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  String route;
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: FlatButton(
        onPressed: () {
          switch(widget.text){
            case "Vis Profil":
              route="/showProfile";
              break;
            case "Rediger":
              route="/editProfile";
              break;
            case "Indstillinger":
              route = "/settings";
              break;
          }
          Navigator.pushNamed(context, route);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(widget.text, style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16)),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey,),
          ],
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.white
      ),
    );
  }
}


