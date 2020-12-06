import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/DatabaseService.dart';
import 'package:flutter_app/size_config.dart';
import 'package:flutter_app/widgets/category_grid.dart';
import 'package:flutter_app/widgets/input_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../../model/user.dart';
import 'package:intl/intl.dart';
import '../../theme.dart';

class AddOrRepostEvent extends StatefulWidget {
  Event event;
  AddOrRepostEvent({this.event});

  @override
  _AddOrRepostEventState createState() => _AddOrRepostEventState();
}

class _AddOrRepostEventState extends State<AddOrRepostEvent> {
  String uid = "";
  MockUser currentUser;
  Event event;
  bool isUploading = false;
  bool isTextfieldValid = true;

  @override
  Widget build(BuildContext context) {
    Event newEvent = Event();

    if (widget.event == null) {
      widget.event = newEvent;
    }

    if (widget.event.date == null) {
      widget.event.date =
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    }

    final authUser = Provider.of<MockUser>(context);
    final key = new GlobalKey<ScaffoldState>();
    PickedFile image;

    Future uploadFile() async {
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('eventPicture/${basename(image.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(File(image.path));

      await uploadTask.onComplete;
      print('File Uploaded');

      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          widget.event.pictureUrl = fileURL;
          isUploading = false;
        });
      });
    }

    //connect camera
    cameraConnect() async {
      print('Picker is Called');
      if (image == null) {
        PickedFile img =
            await ImagePicker().getImage(source: ImageSource.camera);
        if (img != null) {
          image = img;
          setState(
            () {
              isUploading = true;
              uploadFile();
            },
          );
        }
      }
    }

    return Scaffold(
      key: key,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    // Image picker
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: GestureDetector(
                          onTap: cameraConnect,
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 40,
                            height: SizeConfig.blockSizeVertical * 20,
                            color: blue,
                            child: widget.event.pictureUrl == null
                                ? Icon(
                                    Icons.add,
                                    size: 70,
                                    color: Colors.white.withOpacity(0.50),
                                  )
                                : Image.network(
                                    widget.event.pictureUrl,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Tilføj billede",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 3,
                    ),
                    // Title input field
                    InputFormField(
                      initialValue: widget.event?.title ?? "",
                      labelText: "Titel*",
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      height: SizeConfig.blockSizeHorizontal * 15,
                      width: SizeConfig.blockSizeHorizontal * 90,
                      validate: isTextfieldValid,
                      onChanged: (input) => widget.event.title = input,
                    ),
                    // Description input field
                    InputFormField(
                      initialValue: widget.event?.description ?? "",
                      labelText: "Beskrivelse*",
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      height: SizeConfig.blockSizeHorizontal * 35,
                      width: SizeConfig.blockSizeHorizontal * 90,
                      validate: isTextfieldValid,
                      onChanged: (input) => widget.event.description = input,
                    ),
                    // Price input field
                    InputFormField(
                        initialValue: widget.event?.price ?? "",
                        labelText: "Pris",
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        height: SizeConfig.blockSizeHorizontal * 15,
                        width: SizeConfig.blockSizeHorizontal * 90,
                        validate: isTextfieldValid,
                        onChanged: (input) => widget.event.price = input),
                    // Date picker field
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Center(
                        child: Container(
                          child: Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: DateTimeField(
                                initialValue: widget.event?.date != null
                                    ? DateFormat("dd/MM/yyyy")
                                        .parse(widget.event.date + "/2020")
                                    : DateTime.now(),
                                decoration: InputDecoration(
                                  hintStyle: inputFieldTextStyle,
                                  border: InputBorder.none,
                                  labelText: "Vælg Dato*",
                                  counterText: "",
                                ),
                                format: DateFormat("dd/MM/yyyy"),
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                onChanged: (input) {
                                  setState(() {
                                    widget.event.date = (input.day.toString() +
                                        "/" +
                                        input.month.toString() +
                                        "/" +
                                        input.year.toString());
                                  });
                                },
                                onShowPicker: (context, currentValue) {
                                  return showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2100));
                                },
                              )),
                          width: SizeConfig.blockSizeHorizontal * 90,
                          height: SizeConfig.blockSizeHorizontal * 14,
                          margin: const EdgeInsets.only(
                              bottom: 6.0), //Same as `blurRadius` i guess
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[50],
                          ),
                        ),
                      ),
                    ),
                    // City input field
                    InputFormField(
                        initialValue: widget.event?.city ?? "",
                        labelText: "By*",
                        keyboardType: TextInputType.streetAddress,
                        maxLines: 1,
                        height: SizeConfig.blockSizeHorizontal * 15,
                        width: SizeConfig.blockSizeHorizontal * 90,
                        validate: isTextfieldValid,
                        onChanged: (input) => widget.event.city = input),
                    // Category selector
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text("Vælg kategori"),
                    ),
                    CategoryGrid(
                      selectAll: false,
                    ),
                  ],
                ),
                // Create or repost event button
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 30),
                  child: SizedBox(
                    height: 50,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: widget.event == null
                          ? Text(
                              "Repost Event",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            )
                          : Text(
                              "Opret Event",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                      color: blue,
                      onPressed: () {
                        // Check if any of the required fields are null
                        if (widget.event.city == null ||
                            widget.event.title == null ||
                            widget.event.description == null ||
                            widget.event.date == null) {
                          // Show error state of the textfields
                          setState(() {
                            isTextfieldValid = false;
                          });

                          // Show snackbar telling the user to fill out the required fields
                          key.currentState.showSnackBar(
                            SnackBar(
                              content:
                                  Text("Alle de krævede felter skal udfyldes"),
                            ),
                          );
                        } else if (widget.event.pictureUrl == null) {
                          print("${widget.event.date}");
                          key.currentState.showSnackBar(
                            SnackBar(
                              content: Text("Vælg et billede til oplevelsen"),
                            ),
                          );
                        } else {
                          // Set the textfields as valid
                          setState(() {
                            isTextfieldValid = true;
                          });

                          // If the price has not been set, then set it as free
                          if (widget.event.price == null) {
                            widget.event.price = "Gratis";
                          }

                          // Add the event to firebase
                          event = Event(
                              userUid: authUser.uid,
                              title: widget.event.title,
                              pictureUrl: widget.event.pictureUrl,
                              price: widget.event.price,
                              date: widget.event.date,
                              city: widget.event.city,
                              description: widget.event.description);
                          DatabaseService(uid: authUser.uid)
                              .createEventWithUser(authUser.uid, event);

                          // Show a snackbar
                          key.currentState.showSnackBar(
                            SnackBar(
                              content: Text("Event Oprettet"),
                            ),
                          );

                          // Pop the view
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
