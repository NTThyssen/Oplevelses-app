class User {
  String name;
  String imageURL;
  String uid;
  int age;
  String profilePicture;
  Event event;
  Favorite favorite;

  User({this.uid, this.name, this.profilePicture, this.imageURL, this.event, this.favorite});

}

class Favorite {
  Event event;
  User user;

  Favorite({this.event, this.user});
}


class Event {
  String pictureUrl;
  String title;
  String description;
  String price;
  String date;
  String city;

  Event({this.pictureUrl, this.title, this.description, this.price, this.date, this.city});
}

// Friends
final User lasse = User(
  uid: '1',
  name: 'Lasse',
  imageURL: 'images/lasse.jpg',
);

final User christy = User(
  uid: '2',
  name: 'Christy',
  imageURL: 'images/christy.jpg',
);

final User peter = User(
  uid: '3',
  name: 'Peter',
  imageURL: 'images/peter.jpg',
);

final User tine = User(
  uid: '4',
  name: 'Tine',
  imageURL: 'images/tine.jpg',
);

final User andrea = User(
  uid: '5',
  name: 'Andrea',
  imageURL: 'images/andrea.jpg',
);

List<User> friends = [lasse, christy, peter, tine, andrea];
