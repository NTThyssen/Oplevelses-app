class MockUser {
  String name;
  String imageURL;
  String uid;
  int age;
  String profilePicture;
  Event event;
  Favorite favorite;

  MockUser(
      {this.uid,
      this.name,
      this.profilePicture,
      this.imageURL,
      this.event,
      this.favorite});
}

class Favorite {
  Event event;
  MockUser user;

  Favorite({this.event, this.user});
}

class Event {
  String pictureUrl;
  String title;
  String description;
  String price;
  String date;
  String city;

  Event(
      {this.pictureUrl,
      this.title,
      this.description,
      this.price,
      this.date,
      this.city});
}

// Friends
final MockUser lasse = MockUser(
  uid: '1',
  name: 'Lasse',
  imageURL: 'images/lasse.jpg',
);

final MockUser christy = MockUser(
  uid: '2',
  name: 'Christy',
  imageURL: 'images/christy.jpg',
);

final MockUser peter = MockUser(
  uid: '3',
  name: 'Peter',
  imageURL: 'images/peter.jpg',
);

final MockUser tine = MockUser(
  uid: '4',
  name: 'Tine',
  imageURL: 'images/tine.jpg',
);

final MockUser andrea = MockUser(
  uid: '5',
  name: 'Andrea',
  imageURL: 'images/andrea.jpg',
);

List<MockUser> friends = [lasse, christy, peter, tine, andrea];
