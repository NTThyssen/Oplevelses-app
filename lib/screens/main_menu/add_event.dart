import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../../model/user.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:badges/badges.dart';

import '../../theme.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  String title = "";
  String description = "";
  String price = "";
  String date = "";
  String city = "";
  String uploadedFileURL = "";
  String uid = "";
  MockUser currentUser;
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<MockUser>>(context);
    final authUser = Provider.of<MockUser>(context);
    File image;

    Future uploadFile() async {
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('eventPicture/${basename(image.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(image);

      await uploadTask.onComplete;
      print('File Uploaded');

      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          uploadedFileURL = fileURL;
          isUploading = false;
        });
      });
    }

    //connect camera
    cameraConnect() async {
      print('Picker is Called');
      if (image == null) {
        File img = await ImagePicker.pickImage(source: ImageSource.camera);
        if (img != null) {
          print("hello");
          image = img;
          setState(() {
            isUploading = true;
            uploadFile();
          });
        }
      }
    }

    return LoadingOverlay(
      isLoading: isUploading,
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical * 8,
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 40,
                height: SizeConfig.blockSizeVertical * 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  color: Theme.of(context).secondaryHeaderColor,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(uploadedFileURL),
                  ),
                ),
                child: uploadedFileURL != ""
                    ? IconButton(
                        onPressed: () {
                          cameraConnect();
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 50,
                          color: Colors.white.withOpacity(0.50),
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          cameraConnect();
                        },
                        icon: Icon(
                          Icons.add,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Tilføj billede"),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
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
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          onChanged: (input) {
                            setState(() {
                              title = input;
                            });
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          maxLength: 180,
                          decoration: InputDecoration(
                            hintStyle: inputFieldTextStyle,
                            border: InputBorder.none,
                            labelText: "Overskrift",
                            counterText: "",
                          ),
                        ),
                      ),
                      width: SizeConfig.blockSizeHorizontal * 90,
                      height: SizeConfig.blockSizeHorizontal * 14,
                      margin: const EdgeInsets.only(
                          bottom: 6.0), //Same as `blurRadius` i guess
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
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          onChanged: (input) {
                            setState(() {
                              description = input;
                            });
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          maxLength: 180,
                          decoration: InputDecoration(
                            hintStyle: inputFieldTextStyle,
                            border: InputBorder.none,
                            labelText: "Beskrivelse",
                            counterText: "",
                          ),
                        ),
                      ),
                      width: SizeConfig.blockSizeHorizontal * 90,
                      height: SizeConfig.blockSizeHorizontal * 35,
                      margin: const EdgeInsets.only(
                          bottom: 6.0), //Same as `blurRadius` i guess
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
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          onChanged: (input) {
                            setState(() {
                              price = input;
                            });
                          },
                          keyboardType: TextInputType.number,
                          maxLines: null,
                          maxLength: 180,
                          decoration: InputDecoration(
                            hintStyle: inputFieldTextStyle,
                            border: InputBorder.none,
                            labelText: "Pris",
                            counterText: "",
                          ),
                        ),
                      ),
                      width: SizeConfig.blockSizeHorizontal * 90,
                      height: SizeConfig.blockSizeHorizontal * 14,
                      margin: const EdgeInsets.only(
                          bottom: 6.0), //Same as `blurRadius` i guess
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
              /*TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                    ),
                    enabled: true,

                  ),*/
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: DateTimeField(
                          decoration: InputDecoration(
                            hintStyle: inputFieldTextStyle,
                            border: InputBorder.none,
                            labelText: "Vælg Dato",
                            counterText: "",
                          ),
                          format: DateFormat("dd-MM-yyyy"),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          onChanged: (input) {
                            date = (input.day.toString() +
                                "/" +
                                input.month.toString());
                            print(date);
                          },
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                        ),
                      ),
                      width: SizeConfig.blockSizeHorizontal * 90,
                      height: SizeConfig.blockSizeHorizontal * 14,
                      margin: const EdgeInsets.only(
                          bottom: 6.0), //Same as `blurRadius` i guess
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
                              city = input;
                            });
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          maxLength: 180,
                          decoration: InputDecoration(
                            hintStyle: inputFieldTextStyle,
                            border: InputBorder.none,
                            labelText: "by",
                            counterText: "",
                          ),
                        ),
                      ),
                      width: SizeConfig.blockSizeHorizontal * 90,
                      height: SizeConfig.blockSizeHorizontal * 14,
                      margin: const EdgeInsets.only(
                          bottom: 6.0), //Same as `blurRadius` i guess
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
                  child: Text(
                    "Opret Event",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  color: Theme.of(context).secondaryHeaderColor,
                  onPressed: () {
                    currentUser = authUser;
                    currentUser.event = Event(
                        title: title,
                        pictureUrl: uploadedFileURL,
                        price: price,
                        date: date,
                        city: city,
                        description: description);
                    DatabaseService(uid: currentUser.uid)
                        .updateUserDate(currentUser);
                  }),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 12,
              )
            ],
          ),
        ),
      ),
    );
    /*isUploading ? Center(
      child: SpinKitCubeGrid(
        color: Colors.white,
        size: 80.0,
      ),
    ),*/
  }
}

class InoutBoxWithBottomShadow extends StatefulWidget {
  final String labelText;
  final bool bigBox;
  InoutBoxWithBottomShadow(this.labelText, {this.bigBox});

  @override
  _InoutBoxWithBottomShadowState createState() =>
      _InoutBoxWithBottomShadowState();
}

class _InoutBoxWithBottomShadowState extends State<InoutBoxWithBottomShadow> {
  String textInput;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: TextFormField(
                onChanged: (input) {
                  setState(() {});
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
            width: SizeConfig.blockSizeHorizontal * 90,
            height: widget.bigBox == null
                ? SizeConfig.blockSizeHorizontal * 14
                : SizeConfig.blockSizeHorizontal * 35,
            margin: const EdgeInsets.only(
                bottom: 6.0), //Same as `blurRadius` i guess
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
