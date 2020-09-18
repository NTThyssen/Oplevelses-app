import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/size_config.dart';
class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(30, 30, 60, 1),
          toolbarHeight: 45,
          title: Text("Rediger Profil"),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(239, 239, 244, 1),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CameraConnect(),
                    SizedBox(
                      width: 5,
                    ),
                    CameraConnect(),
                    SizedBox(
                      width: 5,
                    ),
                    CameraConnect(),
                  ],
                ),
              ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CameraConnect(),
                      SizedBox(
                        width: 5,
                      ),
                      CameraConnect(),
                      SizedBox(
                        width: 5,
                      ),
                      CameraConnect()
                  ]),
                ),
                Center(
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal*75,
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                    child: Text("Om Mig", style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)
                    ),

                  ),
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white
                    ),
                    width: SizeConfig.blockSizeHorizontal*75,
                    height: SizeConfig.blockSizeVertical*20,
                    //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 10),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        maxLength: 180,
                        decoration: InputDecoration(

                          border: InputBorder.none,
                          hintText: 'Skriv lidt om dig selv'
                      ),
                      ),
                    ),

                  ),
                ),
                Center(
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal*75,
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                    child: Text("By", style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)
                    ),

                  ),
                ),
                Center(
                  child: Container(
                    height: SizeConfig.blockSizeHorizontal*11,
                    width: SizeConfig.blockSizeHorizontal*75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white
                    ),
                    //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 10),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Skriv din by her'
                        ),
                      ),
                    ),

                  ),
                ),
                Center(
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal*75,
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                    child: Text("Job", style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)
                    ),

                  ),
                ),
                Center(
                  child: Container(
                    height: SizeConfig.blockSizeHorizontal*11,
                    width: SizeConfig.blockSizeHorizontal*75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white
                    ),
                    //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 10),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Job'
                        ),
                      ),
                    ),

                  ),
                ),
                Center(
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal*75,
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                    child: Text("Uddannelse", style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)
                    ),

                  ),
                ),
                Center(
                  child: Container(
                    height: SizeConfig.blockSizeHorizontal*11,
                    width: SizeConfig.blockSizeHorizontal*75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white
                    ),
                    //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 10),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Uddannelse'
                        ),
                      ),
                    ),

                  ),
                ),

            ],
      ),
          ),
        ),
    );
  }
}


class ImageContainer extends StatefulWidget {
  @override
  _ImageContainerState createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  File img;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      child: Container(
        width: SizeConfig.blockSizeHorizontal*24,
        height: SizeConfig.blockSizeVertical*14,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(CupertinoIcons.clear_circled_solid, color: Colors.red, )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: Colors.grey[400],
        ),
      ),
      borderType: BorderType.RRect,
      padding: EdgeInsets.all(0),
      radius: Radius.circular(15.0),
      dashPattern: [4, 2, 4, 2],
    );
  }
}

class CameraConnect extends StatefulWidget {
  @override
  _CameraConnectState createState() => _CameraConnectState();
}
class _CameraConnectState extends State<CameraConnect> {
  File image;
  //connect camera
  cameraConnect() async {
    print('Picker is Called');
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                cameraConnect();
              },
              child: Container(
                child: image == null ? DottedBorder(
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal*24,
                    height: SizeConfig.blockSizeVertical*16.66,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(Icons.image),
                        Icon(CupertinoIcons.clear_circled_solid, color: Colors.red, )
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.grey[400],
                    ),
                  ),
                  borderType: BorderType.RRect,
                  padding: EdgeInsets.all(0),
                  radius: Radius.circular(15.0),
                  dashPattern: [4, 2, 4, 2],
                ) : DottedBorder(
                                                                      child: Container(
                                                                      width: SizeConfig.blockSizeHorizontal*24,
                                                                        height: SizeConfig.blockSizeVertical*16.66,
                                                                        child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                                          children: [
                                                                            Stack(
                                                                              children: [
                                                                                ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(15.0),
                                                                                  child: Container(
                                                                                      child: Image.file(image,
                                                                                      width: SizeConfig.blockSizeHorizontal*24,
                                                                                        height: SizeConfig.blockSizeVertical*16.66,
                                                                                      fit: BoxFit.fill,)
                                                                                  ),
                                                                                ),
                                                                                Icon(CupertinoIcons.clear_circled_solid, color: Colors.red, )
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                          color: Colors.grey[400],
                                                                        ),
                                                                      ),
                                                                      borderType: BorderType.RRect,
                                                                      padding: EdgeInsets.all(0),
                                                                      radius: Radius.circular(15.0),
                                                                      dashPattern: [4, 2, 4, 2],
                                                                      ),

              ),
            ),
          ],
        ),
    );
  }
}
