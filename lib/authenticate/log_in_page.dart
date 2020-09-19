import 'package:flutter/material.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 30, 60, 1),
        title: Text("Login"),
      ),
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.amber, Colors.deepOrange])),
        child: SingleChildScrollView(
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 80,
                      child: Icon(Icons.anchor_rounded, size:80, ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, SizeConfig.blockSizeVertical*5, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      width: SizeConfig.blockSizeHorizontal*80,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Username'
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                      ),

                      width: SizeConfig.blockSizeHorizontal*80,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        obscureText: true,
                        decoration: InputDecoration(

                            border: InputBorder.none,
                            hintText: 'Password'
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal*80,
                      child: RaisedButton(
                        color: Color.fromRGBO(30, 30, 60, 1),
                        onPressed: () {  },
                        child: Center(
                            child:
                            Text("SIGN IN", style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)
                            )),
                      ),
                    ),
                  ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0 ,0),
                        child: Divider(
                          height: 10,
                          indent: SizeConfig.blockSizeHorizontal*5,
                          endIndent: SizeConfig.blockSizeHorizontal*5,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10 ,0 ,10),
                        child: Text("Or sign in with", style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.normal,
                            fontSize: 12)
                        ),
                      ),
                      FacebookSignInButton(onPressed: () {
                        // call authentication logic
                      }),

                ],
              ),
        ),
      ),
    );
  }
}
