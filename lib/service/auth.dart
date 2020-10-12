import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // This widget is the root of your application.
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

   //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }
  Future facebookSignIn() async{
    FacebookLogin facebookLogin = FacebookLogin();

    final result = await facebookLogin.logIn(['email', "user_birthday", "user_photos"]);
    print(result.status.toString() + "-----------------------------------");
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,birthday&access_token=$token');
        final profile = json.decode(graphResponse.body);
        final profilePic = profile['id'];
        int width=SizeConfig.screenWidth.toInt();
        int height=SizeConfig.screenHeight.toInt();
        print("{width : $width, heigth: $height}");
        final graphResponse2 = await http.get(
            'https://graph.facebook.com/$profilePic/picture?height=$height&width=$width&redirect=false&access_token=$token');
        final profilepic2 = json.decode(graphResponse2.body);
        print(profile);
        print(profilepic2);
        UserLoginState.instance.setProfilePicture(profilePic: profilepic2['data']['url']);
        UserLoginState.instance.setProfile(profile: profile);
        final creadentials = FacebookAuthProvider.getCredential(accessToken: token);
        await _auth.signInWithCredential(creadentials);
        return true;
      case FacebookLoginStatus.cancelledByUser:
        return null;
      case FacebookLoginStatus.error:
        return null;
    }

  }

  Future registerWithEmail(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid:user.uid).updateUserDate(_userFromFirebaseUser(user));
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future singInWithEmail(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      print(user.displayName);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}

class UserLoginState {
  dynamic isLoggedIn;
  dynamic profile;
  NetworkImage profilePic;

  NetworkImage getProfilePicture(){
    return profilePic;
  }

  void setProfilePicture({profilePic}){
    this.profilePic = NetworkImage(profilePic.toString());
  }

  dynamic getProfile(){
    return profile;
  }

  void setProfile({profile}){
    this.profile = profile;
  }

  UserLoginState._privateConstructor();

  static final UserLoginState instance = UserLoginState._privateConstructor();

}