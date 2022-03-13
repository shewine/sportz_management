import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  final String email;
  final String uid;
  // final String photoUrl;
  final String adminname;
  // final String bio;
  // final List followers;
  // final List following;

  const Admin({
    required this.adminname,
    required this.uid,
    // required this.photoUrl,
    required this.email,
    // required this.bio,
    // required this.followers,
    // required this.following
  });

  static Admin fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Admin(
      adminname: snapshot["adminname"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      // photoUrl: snapshot["photoUrl"],
      // bio: snapshot["bio"],
      // followers: snapshot["followers"],
      // following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
        "adminname": adminname,
        "uid": uid,
        "email": email,
        // "photoUrl": photoUrl,
        // "bio": bio,
        // "followers": followers,
        // "following": following,
      };
}
