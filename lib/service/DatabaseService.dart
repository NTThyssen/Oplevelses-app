import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/event.dart';
import 'package:flutter_app/models/event_request.dart';
import 'package:flutter_app/models/favorite.dart';
import 'package:flutter_app/models/mock_user.dart';

class DatabaseService {
  final String uid;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection("events");
  DatabaseService({this.uid});

  Future updateUserDataOnSignUp(MockUser user) async {
    return await userCollection.doc(user.uid).set({
      'name': user.name,
      'age': user.age.toString(),
      'profilePicture': user.profilePicture.toString()
    });
  }

  Future getFavoriteDataFromEvent(MockUser user) {
    FirebaseFirestore.instance
        .collection("events")
        .where("favorite.", isEqualTo: "USA")
        .get()
        .then((value) {
      value.docs.forEach((result) {
        print(result.data());
      });
    });
  }

  Future createEventWithUser(String userUid, Event event) async {
    return await eventsCollection.doc().set({
      'userUid': userUid,
      'event': {
        'pictureUrl': event.pictureUrl,
        'city': event.city,
        'price': event.price,
        'title': event.title,
        'date': event.date,
        'description': event.description
      },
    });
  }

  Future updateUserData(MockUser user) async {
    final favoriteSnap =
        userCollection.doc(user.uid).collection("favorites").doc();
    print(uid);
    Map<String, String> map = {
      "city": user.favorite.event.city,
      "date": user.favorite.event.date,
      "description": user.favorite.event.description,
      "pictureUrl": user.favorite.event.pictureUrl,
      "price": user.favorite.event.price,
      "title": user.favorite.event.title,
    };
    return await favoriteSnap.set(
      {'userUid': user.favorite.userUid, 'favorites': map},
    );
  }

  Future sendEventRequest(
      String eventUid, String askedUserUid, String userUid) async {
    List<String> list = List();
    list.add(userUid);
    final snapshot =
        await userCollection.doc(askedUserUid).collection("eventRequest").get();
    final eventSnap = userCollection
        .doc(askedUserUid)
        .collection("eventRequest")
        .doc(eventUid);
    if (snapshot.docs.length == 0) {
      eventSnap.set({'userUid': FieldValue.arrayUnion(list)});
    } else {
      eventSnap.get().then((value) => {
            if (value.exists)
              {
                eventSnap.update({'userUid': FieldValue.arrayUnion(list)})
              }
            else
              {
                eventSnap.set({'userUid': FieldValue.arrayUnion(list)})
              }
          });
    }
  }

  List<Event> _eventListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return Event(
            uid: doc.id,
            userUid: doc.data()['userUid'],
            pictureUrl: doc.data()['event']['pictureUrl'],
            title: doc.data()['event']['title'],
            price: doc.data()['event']['price'],
            date: doc.data()['event']['date'],
            description: doc.data()['event']['description'],
            city: doc.data()['event']['city']);
      }).toList();
    } catch (e) {
      print(e.toString());
    }
  }

  List<EventRequest> _eventRequestListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return EventRequest(
          eventUid: doc.id,
          userUid: doc.data()["userUid"],
        );
      }).toList();
    } catch (e) {
      print(e);
    }
  }

  List<MockUser> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MockUser(
        uid: doc.id,
        name: doc.data()['name'],
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
    }).toList();
  }

  Future<MockUser> getUserFromUid(String uid) async {
    DocumentSnapshot doc = await userCollection.doc(uid).get();
    try {
      if (doc.exists && doc.data()["profilePicture"] != null) {
        return MockUser(
            uid: doc.id,
            profilePicture: doc.data()["profilePicture"],
            name: doc.data()["name"],
            age: doc.data()["age"]);
      } else {
        return MockUser(uid: doc.id);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<Favorite>> getUserFavoritesFromUid(String uid) async {
    QuerySnapshot doc =
        await userCollection.doc(uid).collection("favorites").get();
    return doc.docs.map((doc) {
      print(doc.id);
      return Favorite(
        event: Event(
            pictureUrl: doc.data()['favorites']['pictureUrl'],
            title: doc.data()['favorites']['title'],
            price: doc.data()['favorites']['price'],
            date: doc.data()['favorites']['date'],
            description: doc.data()['favorites']['description'],
            city: doc.data()['favorites']['city']),
      );
    }).toList();
  }

  Future<Event> getEventFromUid(String uid) async {
    DocumentSnapshot doc = await eventsCollection.doc(uid).get();

    return Event(
        uid: doc.id,
        description: doc.data()["event"]["description"],
        title: doc.data()["event"]["title"],
        city: doc.data()["event"]["city"],
        pictureUrl: doc.data()["event"]["pictureUrl"],
        userUid: doc.data()["userUid"],
        date: doc.data()["event"]["date"],
        price: doc.data()["event"]["price"]);
  }

  Stream<List<EventRequest>> getEventRequests(String uid) {
    return userCollection
        .doc(uid)
        .collection("eventRequest")
        .snapshots()
        .map(_eventRequestListFromSnapshot);
  }

  Stream<List<MockUser>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }

  Stream<List<Event>> get events {
    return eventsCollection.snapshots().map(_eventListFromSnapshot);
  }
}
