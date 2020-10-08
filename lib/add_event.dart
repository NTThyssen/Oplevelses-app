import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/service/auth.dart';
import 'package:flutter_app/size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'model/user.dart';
import 'widgets/custom_scaffold_with_navBar.dart';

class AddEvent extends StatefulWidget {
  String title = "";
  String description = "";
  String price = "";
  String date = "";
  String city = "";
  String _uploadedFileURL = "";
  String uid = "";
  User currentUser;
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {


  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<User>>(context);
    final authUser = Provider.of<User>(context);
    File image;


    users.forEach((user) {
      widget.currentUser = User(uid: authUser.uid, event: Event(title: widget.title, description: widget.description, date: widget.date, price: widget.price, pictureUrl: widget._uploadedFileURL));
    });

    Future uploadFile() async {
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('eventPicture/${basename(image.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          widget._uploadedFileURL = fileURL;
        });
      });
    }
    //connect camera
    cameraConnect() async {
      print('Picker is Called');
      if(image == null) {
        File img = await ImagePicker.pickImage(source: ImageSource.gallery);
        if (img != null) {
          print("hello");
          image = img;
          setState(() {});
          uploadFile();
        }
      }else{
        image = null;
        setState(() {});
      }

    }


    return Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.blockSizeVertical*8,),
                Container(
                  width: SizeConfig.blockSizeHorizontal*40,
                  height: SizeConfig.blockSizeVertical*25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Theme.of(context).secondaryHeaderColor
                  ),
                  child: IconButton(
                    onPressed: (){
                      cameraConnect();
                    },
                    icon: Icon(Icons.add, size: 50, color: Colors.white,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Tilføj billede"),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical*3,),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: TextFormField(
                          onChanged: (input) {
                            setState(() {
                                widget.title = input;
                            });
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          maxLength: 180,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            labelText: "Overskrift",
                            counterText: "",
                          ),

                        ),
                      ),
                      width: SizeConfig.blockSizeHorizontal*90,
                      height: SizeConfig.blockSizeHorizontal*14,
                      margin: const EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: TextFormField(
                            onChanged: (input) {
                              setState(() {
                                widget.description = input;
                              });
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            maxLength: 180,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              labelText: "Beskrivelse",
                              counterText: "",
                            ),

                          ),
                        ),
                        width: SizeConfig.blockSizeHorizontal*90,
                        height: SizeConfig.blockSizeHorizontal*35,
                        margin: const EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: TextFormField(
                            onChanged: (input) {
                              setState(() {
                                  widget.price = input;
                              });
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            maxLength: 180,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              labelText: "Pris",
                              counterText: "",
                            ),

                          ),
                        ),
                        width: SizeConfig.blockSizeHorizontal*90,
                        height: SizeConfig.blockSizeHorizontal*14,
                        margin: const EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: TextFormField(
                            onChanged: (input) {
                              setState(() {
                                    widget.date = input;
                              });
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            maxLength: 180,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              labelText: "Dato",
                              counterText: "",
                            ),

                          ),
                        ),
                        width: SizeConfig.blockSizeHorizontal*90,
                        height: SizeConfig.blockSizeHorizontal*14,
                        margin: const EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 15),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: TextFormField(
                            onChanged: (input) {
                              setState(() {
                                  widget.city = input;
                              });
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            maxLength: 180,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              labelText: "by",
                              counterText: "",
                            ),

                          ),
                        ),
                        width: SizeConfig.blockSizeHorizontal*90,
                        height: SizeConfig.blockSizeHorizontal*14,
                        margin: const EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                RaisedButton(

                  child: Text("Opret Event", style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),),
                  color: Theme.of(context).secondaryHeaderColor,
                    onPressed: () {
                  widget.currentUser.event.title =   widget.title;
                  widget.currentUser.event.pictureUrl =  widget._uploadedFileURL;
                  widget.currentUser.event.price =  widget.price;
                  widget.currentUser.event.date =  widget.date;
                  widget.currentUser.event.city =  widget.city;
                  widget.currentUser .event.description =  widget.description;
                      DatabaseService(uid: widget.currentUser.uid).updateUserDate(widget.currentUser);

                }),
                SizedBox(
                  height: SizeConfig.blockSizeVertical*12,
                )
              ],
            ),
          ),

    );
  }
}


class InoutBoxWithBottomShadow extends StatefulWidget {
  final String labelText;
  final bool bigBox;
  InoutBoxWithBottomShadow(this.labelText, {this.bigBox});

  @override
  _InoutBoxWithBottomShadowState createState() => _InoutBoxWithBottomShadowState();
}

class _InoutBoxWithBottomShadowState extends State<InoutBoxWithBottomShadow> {
  String textInput;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: TextFormField(
                    onChanged: (input) {
                      setState(() {

                      });
                      },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 180,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    labelText: widget.labelText,
                    counterText: "",
                ),

              ),
            ),
            width: SizeConfig.blockSizeHorizontal*90,
            height: widget.bigBox == null ? SizeConfig.blockSizeHorizontal*14 : SizeConfig.blockSizeHorizontal*35,
            margin: const EdgeInsets.only(bottom: 6.0), //Same as `blurRadius` i guess
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


