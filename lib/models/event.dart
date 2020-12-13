import 'package:flutter_app/models/user.dart';

class Event {
  String uid;
  String userUid;
  String pictureUrl;
  String title;
  String description;
  String price;
  String date;
  String city;
  MockUser user;
  Event(
      {this.uid,
      this.userUid,
      this.pictureUrl,
      this.title,
      this.description,
      this.price,
      this.date,
      this.city,
      this.user});
}
