class User {
  String name;
  String uid;
  int age;
  String profilePicture;
  Favorite favorite;

  User({this.uid, this.name, this.profilePicture, this.favorite});

}

class Favorite {
  Event event;
  User user;

  Favorite({this.event, this.user});
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

  Event({this.uid, this.userUid, this.pictureUrl, this.title, this.description, this.price, this.date, this.city});
}

class EventRequest {
  String eventUid;
  String userUid;

  EventRequest({this.eventUid, this.userUid});
}

// Friends
final User lasse = User(
  uid: '1',
  name: 'Lasse',
  profilePicture: 'images/lasse.jpg',
);

final User christy = User(
  uid: '2',
  name: 'Christy',
  profilePicture: 'images/christy.jpg',
);

final User peter = User(
  uid: '3',
  name: 'Peter',
  profilePicture: 'images/peter.jpg',
);

final User tine = User(
  uid: '4',
  name: 'Tine',
  profilePicture: 'images/tine.jpg',
);

final User andrea = User(
  uid: '5',
  name: 'Andrea',
  profilePicture: 'images/andrea.jpg',
);

List<User> friends = [lasse, christy, peter, tine, andrea];
