import 'package:cloud_firestore/cloud_firestore.dart';

class Events {
  final String eventTitle;
  final String uid;
  final String eventDesc;
  final String eventsId;
  final registeredUsers;
  final String eventsId;

  const Events({
    required this.eventTitle,
    required this.uid,
    required this.eventDesc,
    required this.registeredUsers,
    required this.eventsId,
  });

  static Events fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Events(
        eventTitle: snapshot["eventTitle"],
        uid: snapshot["uid"],
        registeredUsers: snapshot["registeredUsers"],
        eventsId: snapshot["EventsId"],
        eventDesc: snapshot["eventDesc"]);
  }

  Map<String, dynamic> toJson() => {
        "eventTitle": eventTitle,
        "uid": uid,
        "registeredUsers": registeredUsers,
        "eventDesc": eventDesc,
        "eventsId": eventsId,
      };
}
