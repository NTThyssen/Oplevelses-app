import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  
  final CollectionReference userCollection = Firestore.instance.collection("users");

  DatabaseService({this.uid});


  Future updateUserDate(String name, String eventPicture ) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'eventPicture' : eventPicture
    });
  }


  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}