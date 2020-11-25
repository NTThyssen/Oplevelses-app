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

class Favorite {
  Event event;
  String userUid;

  Favorite({this.event, this.userUid});
}

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

class EventRequest {
  String eventUid;
  List userUid;

  EventRequest({this.eventUid, this.userUid});
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
