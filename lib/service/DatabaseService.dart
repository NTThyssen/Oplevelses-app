import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/user.dart';

class DatabaseService {
  final String uid;

  final CollectionReference userCollection = Firestore.instance.collection("users");
  DatabaseService({this.uid});


  Future updateUserDate(User user) async {
    print(uid);
    return await userCollection.document(uid).setData({
      'name': user.name,
      'event': {
        'pictureUrl' : user.event.pictureUrl,
        'city' : user.event.city,
        'price' : user.event.price,
        'title' : user.event.title,
        'date' : user.event.date,
        'description' : user.event.description

      },
    });
  }

  List<User> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return User(
          name: doc.data['name'],
          event: Event(pictureUrl: doc.data['event']['pictureUrl'], title: doc.data['event']['title'],
              price: doc.data['event']['price'],
              date: doc.data['event']['date'],
              description: doc.data['event']['description'],

              city: doc.data['event']['city']
          ),

      );
    }).toList();
  }



  Stream<List<User>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }
}