import 'package:cloud_firestore/cloud_firestore.dart';

class Events {
  final String eventName;
  // final String uid;
  final String eventDesc;
  final String eventId;
  final registeredUsers;
  final String eventType;
  final String eventWinner;
  final String eventDate;

  const Events({
    required this.eventName,
    // required this.uid,
    required this.eventDesc,
    required this.registeredUsers,
    required this.eventId,
    required this.eventType,
    required this.eventWinner,
    required this.eventDate,
  });

  static Events fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Events(
      eventName: snapshot["eventName"],
      // uid: snapshot["uid"],
      eventDesc: snapshot["eventDesc"],
      eventId: snapshot["EventsId"],
      registeredUsers: snapshot["registeredUsers"],
      eventType: snapshot["eventType"],
      eventWinner: snapshot["eventWinner"],
      eventDate: snapshot["eventDate"],
    );
  }

  Map<String, dynamic> toJson() => {
        "eventName": eventName,
        // "uid": uid,
        "eventDesc": eventDesc,
        "eventId": eventId,
        "registeredUsers": registeredUsers,
        "eventType": eventType,
        "eventWinner": eventWinner,
        "eventDate": eventDate,
      };
}
