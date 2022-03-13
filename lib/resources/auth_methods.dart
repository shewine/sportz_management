import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sportz_management/models/admin.dart' as model;
import 'package:sportz_management/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    // required String bio,
    // required Uint8List file,
  }) async {
    String res = "Some error";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty
          // ||
          // bio.isNotEmpty ||
          // // ignore: unnecessary_null_comparison
          // file != null
          ) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // String photoUrl = await StorageMethods()
        //     .uploadImageToStorage('profilePics', file, false);

        model.User _user = model.User(
          username: username,
          uid: cred.user!.uid,
          // photoUrl: photoUrl,
          email: email,
          // bio: bio,
          // followers: [],
          // following: [],
        );

        // // adding user in our database
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        // await _firestore.collection("users").doc(cred.user!.uid).set({
        //   ' username': username,
        //   'uid': cred.user!.uid,
        //   'photoUrl': photoUrl,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> signUpAdmin({
    required String email,
    required String password,
    required String adminname,
    // required String bio,
    // required Uint8List file,
  }) async {
    String res = "Some error";
    try {
      if (email.isNotEmpty || password.isNotEmpty || adminname.isNotEmpty
          // ||
          // bio.isNotEmpty ||
          // // ignore: unnecessary_null_comparison
          // file != null
          ) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // String photoUrl = await StorageMethods()
        //     .uploadImageToStorage('profilePics', file, false);

        model.Admin _admin = model.Admin(
          adminname: adminname,
          uid: cred.user!.uid,
          // photoUrl: photoUrl,
          email: email,
          // bio: bio,
          // followers: [],
          // following: [],
        );

        // // adding user in our database
        await _firestore
            .collection("admin")
            .doc(cred.user!.uid)
            .set(_admin.toJson());

        // await _firestore.collection("users").doc(cred.user!.uid).set({
        //   ' username': username,
        //   'uid': cred.user!.uid,
        //   'photoUrl': photoUrl,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
