import 'package:flutter/material.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_app/service/auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoggingIn = false;
  AuthService signIn = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 30, 60, 1),
        title: Text("Login"),
      ),
      body: (isLoggingIn) ? Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: 80.0,
        ),
      ) :  Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.transparent, Colors.purple])),
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
                padding: const EdgeInsets.fromLTRB(0, 10 ,0 ,10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text("Continue for now", style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.normal,
                      fontSize: 12)
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
              FacebookSignInButton(onPressed: () async {

                setState(() {
                  isLoggingIn = true;
                });
                if (await signIn.facebookSignIn() != null) {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (BuildContext context) => MyApp()));
                }
                else {
                  print("you have to sign in");
                  setState(() {
                    isLoggingIn = false;
                  });
                }


              }),

            ],
          ),
        ),
      ),
    );
  }
}





