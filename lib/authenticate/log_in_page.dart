import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/authenticate/sing_up.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/screens/home/home_screen.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_app/theme.dart';
import 'package:flutter_app/widgets/custom_scaffold_with_navBar.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_app/service/auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  bool isLoggingIn = false;
  AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: (isLoggingIn)
          ? Center(
              child: SpinKitCubeGrid(
                color: Colors.white,
                size: 80.0,
              ),
            )
          : Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Container(
                        height: 150,
                        child: Image.asset(
                          "images/balloon.png",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "We Do Activities",
                        textAlign: TextAlign.center,
                        style: titleTextStyle.copyWith(fontSize: 60),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, SizeConfig.blockSizeVertical * 5, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border(
                                      bottom:
                                          BorderSide(width: 2.0, color: blue))),
                              width: SizeConfig.blockSizeHorizontal * 80,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  primaryColor: blue,
                                ),
                                child: TextFormField(
                                  style: TextStyle(color: white),
                                  textAlign: TextAlign.left,
                                  validator: (val) =>
                                      val.isEmpty ? "enter email" : null,
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                      print(val);
                                    });
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email_outlined),
                                      hintStyle: inputFieldTextStyle,
                                      border: InputBorder.none,
                                      hintText: 'Email'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border(
                                      bottom:
                                          BorderSide(width: 2.0, color: blue))),
                              width: SizeConfig.blockSizeHorizontal * 80,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  primaryColor: blue,
                                ),
                                child: TextFormField(
                                  style: TextStyle(color: white),
                                  textAlign: TextAlign.left,
                                  obscureText: true,
                                  validator: (val) => val.length < 6
                                      ? "must be greater than 6 chars"
                                      : null,
                                  onChanged: (val) {
                                    setState(() {
                                      password = val;
                                      print(val);
                                    });
                                  },
                                  decoration: InputDecoration(
                                      hintStyle: inputFieldTextStyle,
                                      prefixIcon: Icon(Icons.lock_outline),
                                      border: InputBorder.none,
                                      hintText: 'Password'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 20),
                            child: Container(
                              height: 55,
                              width: SizeConfig.blockSizeHorizontal * 80,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: blue,
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    dynamic result = await _auth
                                        .singInWithEmail(email, password);
                                    print(result);
                                    Navigator.pushReplacement(
                                        context, FadeRoute(page: MyApp()));
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    "Log ind",
                                    style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 0.8,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 55,
                            width: SizeConfig.blockSizeHorizontal * 80,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: blue,
                              onPressed: () async {
                                await _auth.signInAnon();
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Text(
                                  "Log ind anonymt",
                                  style: TextStyle(
                                    color: Colors.black,
                                    letterSpacing: 0.8,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 10,
                      indent: SizeConfig.blockSizeHorizontal * 5,
                      endIndent: SizeConfig.blockSizeHorizontal * 5,
                      thickness: 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => SignUp()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Divider(
                                  color: white,
                                  height: 36,
                                ),
                              ),
                            ),
                            Text(
                              "Eller",
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Divider(
                                  color: white,
                                  height: 36,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Container(
                        height: 55,
                        width: SizeConfig.blockSizeHorizontal * 80,
                        child: FacebookSignInButton(
                            borderRadius: 10,
                            onPressed: () async {
                              setState(() {
                                isLoggingIn = true;
                              });
                              var result = await _auth.facebookSignIn();
                              print(result);
                              if (result != null) {
                                Navigator.pop(context);
                              } else {
                                print("you have to sign in");
                                setState(() {
                                  isLoggingIn = false;
                                });
                              }
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
