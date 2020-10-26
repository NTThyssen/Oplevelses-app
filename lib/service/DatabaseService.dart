import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/model/user.dart';

class DatabaseService {
  final String uid;

  final CollectionReference userCollection = Firestore.instance.collection("users");
  final CollectionReference eventsCollection = Firestore.instance.collection("events");
  DatabaseService({this.uid});


  Future updateUserDate(User user) async {
    print(uid);
    return await userCollection.doc(uid).set({
      'name': user.name,

    });
  }

  Future createEventWithUser(String userUid, Event event) async {
    var doc_ref = await Firestore.instance.collection("board").document(userUid);
    User user = await doc_ref.get().then((value) => User());
    return await eventsCollection.document().setData({
      'userUid': userUid,
      'event': {
        'pictureUrl' : event.pictureUrl,
        'city' : event.city,
        'price' : event.price,
        'title' : event.title,
        'date' : event.date,
        'description' : event.description
      },
    });
  }

  Future updateUserData(User user) async {
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

  Future sendEventRequest(String eventUid, String askedUserUid, String userUid) async {
    return await userCollection.document(askedUserUid).collection("eventRequest").document().setData({
      'eventUid': eventUid,
      'userUid': userUid,
    });
  }


  List<Event> _eventListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
        return Event(
          uid : doc.documentID,
          userUid: doc.data['userUid'],
          pictureUrl:  doc.data['event']['pictureUrl'],
            title: doc.data['event']['title'],
              price: doc.data['event']['price'],
              date: doc.data['event']['date'],
              description: doc.data['event']['description'],
              city: doc.data['event']['city']
          );
    }).toList();
    }


  List<EventRequest> _EventRequestListFromSnapshot(QuerySnapshot snapshot){

    return snapshot.documents.map((doc) {
      if(doc.data["favorite"] == null){
        return EventRequest(
          eventUid: doc.documentID,
          userUid: doc.data['name'],

        );
      }
    }).toList();
  }

  List<User> _userListFromSnapshot(QuerySnapshot snapshot){

    return snapshot.documents.map((doc) {
      if(doc.data["favorite"] == null){
        return User(
          uid: doc.documentID,
            name: doc.data['name'],

            );
      }else{
        return User(
          uid: doc.documentID,
          name: doc.data['name'],
          favorite: Favorite(event: Event(pictureUrl: doc.data['favorite']['pictureUrl'] ,
              title: doc.data['favorite']['title'],
              price: doc.data['favorite']['price'],
              date: doc.data['favorite']['date'],
              description: doc.data['favorite']['description'],
              city: doc.data['favorite']['city']),
          ),
        );
      }
    }).toList();
  }

  User _userFromSnapShot(DocumentSnapshot doc){
    return User(uid: doc.documentID);
  }

  Future<User> getUserFromUid(String uid) async {
    DocumentSnapshot doc = await eventsCollection.document(uid).get();
    return _userFromSnapShot(doc);
  }

  Stream<List<EventRequest>> getRequest(String uid){
    return userCollection.document(uid).collection("eventRequest").snapshots().map(_EventRequestListFromSnapshot);

  }


  Stream<List<User>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }


  Stream<List<Event>> get events {
    return userCollection.snapshots().map(_eventListFromSnapshot);
  }

}