import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/mock_user.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/service/auth.dart';
import 'package:flutter_app/theme.dart';
import 'package:flutter_app/mixins/basic_mixin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import '../main.dart';
import '../size_config.dart';

class SignUp extends StatefulWidget {
  String email;
  String password;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoggingIn = false;
  AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File image;
  MockUser user = MockUser();
  @override
  Widget build(BuildContext context) {
    File tempImage = image;

    Future uploadFile() async {
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('profilePicture/${basename(tempImage.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(tempImage);

      await uploadTask.onComplete;
      print('File Uploaded');

      await storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          user.profilePicture = fileURL;
          print(user.profilePicture + " what the fuycj");
        });
      });
    }

    //connect camera
    cameraConnect() async {
      print('Picker is Called');
      if (image == null) {
        File img = await ImagePicker.pickImage(source: ImageSource.camera);
        if (img != null) {
          image = img;
          setState(() {});
        }
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: GestureDetector(
                          onTap: () async {
                            await cameraConnect();
                            setState(() {});
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: image != null
                                ? AssetImage(image.path)
                                : AssetImage("images/no-profile-img.jpg"),
                            radius: 80,
                          ),
                        ),
                      ),
                      Text(
                        "Tryk for at tilføje billede",
                        style: TextStyle(color: Colors.white),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 2.0,
                                            color: Theme.of(context)
                                                .secondaryHeaderColor))),
                                width: SizeConfig.blockSizeHorizontal * 80,
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  onChanged: (val) {
                                    setState(() {
                                      user.name = val;
                                      print(val);
                                    });
                                  },
                                  decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                          color: Theme.of(context)
                                              .secondaryHeaderColor),
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: white,
                                      ),
                                      border: InputBorder.none,
                                      labelText: "Navn"),
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
                                            width: 2.0,
                                            color: Theme.of(context)
                                                .secondaryHeaderColor))),
                                width: SizeConfig.blockSizeHorizontal * 80,
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  onChanged: (val) {
                                    setState(() {
                                      user.age = val;
                                      print(val);
                                    });
                                  },
                                  decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                          color: Theme.of(context)
                                              .secondaryHeaderColor),
                                      prefixIcon: Icon(
                                        Icons.calendar_today,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                      ),
                                      border: InputBorder.none,
                                      labelText: "Alder"),
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
                                            width: 2.0,
                                            color: Theme.of(context)
                                                .secondaryHeaderColor))),
                                width: SizeConfig.blockSizeHorizontal * 80,
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  onChanged: (val) {
                                    widget.email = val;
                                    setState(() {
                                      print(val);
                                    });
                                  },
                                  decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                          color: Theme.of(context)
                                              .secondaryHeaderColor),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                      ),
                                      border: InputBorder.none,
                                      labelText: "Email"),
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
                                            width: 2.0,
                                            color: Theme.of(context)
                                                .secondaryHeaderColor))),
                                width: SizeConfig.blockSizeHorizontal * 80,
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  obscureText: true,
                                  validator: (val) => val.length < 6
                                      ? "must be greater than 6 chars"
                                      : null,
                                  onChanged: (val) {
                                    widget.password = val;
                                    setState(() {
                                      print(val);
                                    });
                                  },
                                  decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                          color: Theme.of(context)
                                              .secondaryHeaderColor),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                      ),
                                      border: InputBorder.none,
                                      labelText: "Password"),
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
                                      print(widget.email + widget.password);
                                      dynamic result =
                                          await _auth.registerWithEmail(
                                              widget.email,
                                              widget.password,
                                              user);
                                      dynamic status = await uploadFile();
                                      print(status.toString() +
                                          " this is status ");
                                      print(user.profilePicture);

                                      DatabaseService()
                                          .updateUserDataOnSignUp(user);
                                      Navigator.pushReplacement(
                                          context, FadeRoute(page: MyApp()));
                                    }
                                  },
                                  child: Center(
                                      child: Text("SIGN UP",
                                          style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: 0.8,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class FormInputField extends StatefulWidget {
  String labelText;
  IconData prefixicon;
  bool obscureText;

  FormInputField(this.labelText, this.prefixicon, {this.obscureText});

  @override
  _FormInputFieldState createState() => _FormInputFieldState();
}

class _FormInputFieldState extends State<FormInputField> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
