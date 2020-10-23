import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/authenticate/sing_up.dart';
import 'package:flutter_app/model/user.dart';
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
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 30, 60, 1),
        title: Text("Login"),
      ),
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
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 80,
                        child: Icon(
                          Icons.access_alarms,
                          size: 80,
                        ),
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
                                      bottom: BorderSide(
                                          width: 2.0, color: Colors.blueGrey))),
                              width: SizeConfig.blockSizeHorizontal * 80,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  primaryColor:
                                      Theme.of(context).secondaryHeaderColor,
                                ),
                                child: TextFormField(
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
                                      prefixIcon: Icon(Icons.person_outline),
                                      hintStyle: inputFieldTextStyle,
                                      border: InputBorder.none,
                                      hintText: 'Email'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 2.0, color: Colors.blueGrey))),
                              width: SizeConfig.blockSizeHorizontal * 80,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  primaryColor:
                                      Theme.of(context).secondaryHeaderColor,
                                ),
                                child: TextFormField(
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
                                      prefixIcon: Icon(Icons.vpn_key),
                                      border: InputBorder.none,
                                      hintText: 'Password'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal * 80,
                              child: RaisedButton(
                                color: Theme.of(context).secondaryHeaderColor,
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    dynamic result = await _auth
                                        .singInWithEmail(email, password);
                                    print(result);
                                    Navigator.pushReplacement(
                                        context, FadeRoute(page: MainPage()));
                                  }
                                },
                                child: Center(
                                    child: Text("SIGN IN",
                                        style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 0.8,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal * 80,
                              child: RaisedButton(
                                color: Theme.of(context).secondaryHeaderColor,
                                onPressed: () async {
                                  await _auth.signInAnon();
                                  Navigator.pop(context);
                                },
                                child: Center(
                                    child: Text("SIGN IN ANONYMOUSLY",
                                        style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 0.8,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: Text("Continue for now",
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.normal,
                                fontSize: 12)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Divider(
                        height: 10,
                        indent: SizeConfig.blockSizeHorizontal * 5,
                        endIndent: SizeConfig.blockSizeHorizontal * 5,
                        thickness: 2,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => SignUp()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text("Or sign in with",
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.normal,
                                fontSize: 12)),
                      ),
                    ),
                    FacebookSignInButton(onPressed: () async {
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
                  ],
                ),
              ),
            ),
    );
  }
}
