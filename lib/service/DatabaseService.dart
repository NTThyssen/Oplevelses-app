import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/model/user.dart';

class DatabaseService {
  final String uid;

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference eventsCollection = FirebaseFirestore.instance.collection("events");
  DatabaseService({this.uid});


  Future updateUserDate(MockUser user) async {
    print(uid);
    return await userCollection.doc(uid).set({
      'name': user.name,

    });
  }

  Future createEventWithUser(String userUid, Event event) async {
    return await eventsCollection.doc().set({
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

  Future sendEventRequest(String eventUid, String askedUserUid, String userUid) async {
    return await userCollection.doc(askedUserUid).collection("eventRequest").doc().set({
      'eventUid': eventUid,
      'userUid': userUid,
    });
  }


  List<Event> _eventListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
        return Event(
          uid : doc.id,
          userUid: doc.data()['userUid'],
          pictureUrl:  doc.data()['event']['pictureUrl'],
            title: doc.data()['event']['title'],
              price: doc.data()['event']['price'],
              date: doc.data()['event']['date'],
              description: doc.data()['event']['description'],
              city: doc.data()['event']['city']
          );
    }).toList();
    }


  List<EventRequest> _eventRequestListFromSnapshot(QuerySnapshot snapshot){

    return snapshot.docs.map((doc) {
      if(doc.data()["favorite"] == null){
        return EventRequest(
          eventUid: doc.id,
          userUid: doc.data()['name'],

        );
      }
    }).toList();
  }

  List<MockUser> _userListFromSnapshot(QuerySnapshot snapshot){

    return snapshot.docs.map((doc) {
      if(doc.data()["favorite"] == null){
        return MockUser(
          uid: doc.id,
            name: doc.data()['name'],

            );
      }else{
        return MockUser(
          uid: doc.id,
          name: doc.data()['name'],
          favorite: Favorite(event: Event(pictureUrl: doc.data()['favorite']['pictureUrl'] ,
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

  MockUser _userFromSnapShot(DocumentSnapshot doc){
    return MockUser(uid: doc.id);
  }

  Future<MockUser> getUserFromUid(String uid) async {
    DocumentSnapshot doc = await eventsCollection.doc(uid).get();
    return _userFromSnapShot(doc);
  }

  Stream<List<EventRequest>> getRequest(String uid){
    return userCollection.doc(uid).collection("eventRequest").snapshots().map(_eventRequestListFromSnapshot);

  }


  Stream<List<MockUser>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }


  Stream<List<Event>> get events {
    return eventsCollection.snapshots().map(_eventListFromSnapshot);
  }

}