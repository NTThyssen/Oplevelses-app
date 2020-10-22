import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/user.dart';

class DatabaseService {
  final String uid;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  DatabaseService({this.uid});

  Future updateUserDate(MockUser user) async {
    print(uid);
    return await userCollection.doc(uid).set({
      'name': user.name,
      'event': {
        'pictureUrl': user.event.pictureUrl,
        'city': user.event.city,
        'price': user.event.price,
        'title': user.event.title,
        'date': user.event.date,
        'description': user.event.description
      },
    });
  }

  Future updateUserData(MockUser user) async {
    print(uid);
    return await userCollection.doc(uid).update({
      'name': user.name,
      'favorite': {
        'pictureUrl': user.favorite.event.pictureUrl,
        'city': user.favorite.event.city,
        'price': user.favorite.event.price,
        'title': user.favorite.event.title,
        'date': user.favorite.event.date,
        'description': user.favorite.event.description
      }
    });
  }

  List<MockUser> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      if (doc.data()["favorite"] == null) {
        return MockUser(
          uid: doc.id,
          name: doc.data()['name'],
          event: Event(
              pictureUrl: doc.data()['event']['pictureUrl'],
              title: doc.data()['event']['title'],
              price: doc.data()['event']['price'],
              date: doc.data()['event']['date'],
              description: doc.data()['event']['description'],
              city: doc.data()['event']['city']),
        );
      } else {
        return MockUser(
          uid: doc.id,
          name: doc.data()['name'],
          event: Event(
              pictureUrl: doc.data()['event']['pictureUrl'],
              title: doc.data()['event']['title'],
              price: doc.data()['event']['price'],
              date: doc.data()['event']['date'],
              description: doc.data()['event']['description'],
              city: doc.data()['event']['city']),
          favorite: Favorite(
            event: Event(
                pictureUrl: doc.data()['favorite']['pictureUrl'],
                title: doc.data()['favorite']['title'],
                price: doc.data()['favorite']['price'],
                date: doc.data()['favorite']['date'],
                description: doc.data()['favorite']['description'],
                city: doc.data()['favorite']['city']),
          ),
        );
      }
    }).toList();
  }

  Stream<List<MockUser>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }
}
