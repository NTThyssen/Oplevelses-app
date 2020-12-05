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
  @override
  Widget build(BuildContext context) {
    Event newEvent = Event();

    if (widget.event == null) {
      widget.event = newEvent;
    }

    final authUser = Provider.of<MockUser>(context);
    final key = new GlobalKey<ScaffoldState>();
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
          widget.event.pictureUrl = fileURL;
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

    return Scaffold(
      key: key,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 30),
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
            // Image picker
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 40,
                height: SizeConfig.blockSizeVertical * 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  color: blue,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: widget.event.pictureUrl == null
                        ? NetworkImage("")
                        : NetworkImage(widget.event.pictureUrl),
                  ),
                ),
                child: widget.event?.pictureUrl != ""
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text("Tilføj billede"),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            // Title input field
            InputFormField(
              value: widget.event.title,
              initialValue: widget.event?.title ?? "",
              labelText: "Titel",
              maxLines: 1,
              keyboardType: TextInputType.text,
              height: SizeConfig.blockSizeHorizontal * 15,
              width: SizeConfig.blockSizeHorizontal * 90,
            ),
            // Description input field
            InputFormField(
              value: widget.event.description,
              initialValue: widget.event?.description ?? "",
              labelText: "Beskrivelse",
              maxLines: null,
              keyboardType: TextInputType.multiline,
              height: SizeConfig.blockSizeHorizontal * 35,
              width: SizeConfig.blockSizeHorizontal * 90,
            ),
            // Price input field
            InputFormField(
              value: widget.event.price,
              initialValue: widget.event?.price ?? "",
              labelText: "Pris",
              maxLines: 1,
              keyboardType: TextInputType.number,
              height: SizeConfig.blockSizeHorizontal * 15,
              width: SizeConfig.blockSizeHorizontal * 90,
            ),
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
                          labelText: "Vælg Dato",
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
                              initialDate: currentValue ?? DateTime.now(),
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
              value: widget.event.city,
              initialValue: widget.event?.city ?? "",
              labelText: "By",
              keyboardType: TextInputType.streetAddress,
              maxLines: 1,
              height: SizeConfig.blockSizeHorizontal * 15,
              width: SizeConfig.blockSizeHorizontal * 90,
            ),
            // Category selector
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text("Vælg kategori"),
            ),
            CategoryGrid(
              selectAll: false,
            ),
            // Create or repost event button
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: SizedBox(
                height: 50,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
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
                      key.currentState.showSnackBar(
                          SnackBar(content: Text("Event Oprettet")));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
