class User {
  int id;
  String name;
  String imageURL;

  User({this.id, this.name, this.imageURL});
}

// Friends
final User lasse = User(
  id: 1,
  name: 'Lasse',
  imageURL: 'images/lasse.jpg',
);

final User christy = User(
  id: 2,
  name: 'Christy',
  imageURL: 'images/christy.jpg',
);

final User peter = User(
  id: 3,
  name: 'Peter',
  imageURL: 'images/peter.jpg',
);

final User tine = User(
  id: 4,
  name: 'Tine',
  imageURL: 'images/tine.jpg',
);

final User andrea = User(
  id: 5,
  name: 'Andrea',
  imageURL: 'images/andrea.jpg',
);

List<User> friends = [lasse, christy, peter, tine, andrea];
