import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_app/widgets/custom_scaffold_with_navBar.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWithNavBar(
      Container(
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              TitleAndTextField(
                  "Om Mig", "Skriv lidt om dig selv", 75, 20, true),
              TitleAndTextField("By", "Skriv din by her", 75, 6, false),
              TitleAndTextField("Job", "Skriv dit job her", 75, 6, false),
              TitleAndTextField(
                  "Udannelse", "Skriv din uddannelse her", 75, 6, false),
            ],
          ),
        ),
      ),
    );
  }
}

class CameraConnect extends StatefulWidget {
  @override
  _CameraConnectState createState() => _CameraConnectState();
}

class _CameraConnectState extends State<CameraConnect> {
  File image;
  String _uploadedFileURL;
  //connect camera
  cameraConnect() async {
    print('Picker is Called');
    if (image == null) {
      File img = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (img != null) {
      image = img;
      setState(() {});
      uploadFile();
      }
    } else {
      image = null;
      setState(() {});
    }

  }
  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('eventPicture/${basename(image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              child: image == null
                  ? DottedBorder(
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 24,
                        height: SizeConfig.blockSizeVertical * 16.66,
                        child: Stack(
                          //mainAxisAlignment: MainAxisAlignment.end,
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Center(
                                child: Icon(
                              Icons.image,
                              size: 50,
                            )),
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
                    )
                  : DottedBorder(
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 24,
                        height: SizeConfig.blockSizeVertical * 16.66,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Container(
                                      child: Image.file(
                                    image,
                                    width: SizeConfig.blockSizeHorizontal * 24,
                                    height:
                                        SizeConfig.blockSizeVertical * 16.66,
                                    fit: BoxFit.fill,
                                  )),
                                ),
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
          Positioned(
              bottom: 0.0,
              right: 0.0,
              child: image == null
                  ? GestureDetector(
                      onTap: () {
                        cameraConnect();
                      },
                      child: Icon(
                        CupertinoIcons.add_circled_solid,
                        color: Colors.green,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        cameraConnect();
                      },
                      child: Icon(
                        CupertinoIcons.clear_thick_circled,
                        color: Colors.red,
                      ),
                    )),
        ],
      ),
    );
  }
}

class TitleAndTextField extends StatefulWidget {
  final String text;
  final String hintText;
  final int height;
  final int width;
  final bool maxLines;

  TitleAndTextField(
      this.text, this.hintText, this.width, this.height, this.maxLines);

  @override
  _TitleAndTextFieldState createState() => _TitleAndTextFieldState();
}

class _TitleAndTextFieldState extends State<TitleAndTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: SizeConfig.blockSizeHorizontal * widget.width,
            padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
            child: Text(widget.text,
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ),
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            width: SizeConfig.blockSizeHorizontal * widget.width,
            height: SizeConfig.blockSizeVertical * widget.height,
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 10),
              child: widget.maxLines == true
                  ? TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      maxLength: 180,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.hintText,
                        counterText: "",
                      ),
                    )
                  : TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.hintText,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
