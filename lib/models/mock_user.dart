import 'package:flutter_app/models/favorite.dart';

class MockUser {
  String name;
  String uid;
  String age;
  String description;
  String profilePicture;
  Favorite favorite;

  MockUser(
      {this.uid,
      this.name,
      this.description,
      this.profilePicture,
      this.favorite,
      this.age});
}

// Friends
final MockUser lasse = MockUser(
  uid: '1',
  name: 'Lasse',
  profilePicture: 'images/lasse.jpg',
);

final MockUser christy = MockUser(
  uid: '2',
  name: 'Christy',
  profilePicture: 'images/christy.jpg',
);

final MockUser peter = MockUser(
  uid: '3',
  name: 'Peter',
  profilePicture: 'images/peter.jpg',
);

final MockUser tine = MockUser(
  uid: '4',
  name: 'Tine',
  profilePicture: 'images/tine.jpg',
);

final MockUser andrea = MockUser(
  uid: '5',
  name: 'Andrea',
  profilePicture: 'images/andrea.jpg',
);

List<MockUser> friends = [lasse, christy, peter, tine, andrea];
