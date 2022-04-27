import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../models/events.dart';

// import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadEvent(
    String eventDesc,
    // String uid,
    String eventName,
    String eventType,
    String eventWinner,
    String eventDate,
  ) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String eventId = const Uuid().v1(); // creates unique id based on time
      Events event = Events(
        eventDesc: eventDesc,
        // uid: uid,
        eventName: eventName,
        registeredUsers: [],
        eventId: eventId,
        eventType: eventType,
        eventWinner: eventWinner,
        eventDate: eventDate,

        // postUrl: photoUrl,
        // profImage: profImage,
      );
      _firestore.collection('Tasks').doc(eventId).set(event.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('Tasks').doc(postId).update({
          'registeredUsers': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('Tasks').doc(postId).update({
          'registeredUsers': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
