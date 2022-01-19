import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/Verification%20Screens/verification_screen.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  // SignUp Method
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SignIn method
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SignOut Method
  Future signOut(context) async {
    await _auth.signOut();
    print('signout');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MainRegistration()),
        (route) => false);
  }

  //getUserDetails
  Future<void> storeUserDetails(name, username) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    String email = auth.currentUser!.email.toString();

    userCollection
        .doc(uid)
        .set({
          "Info": {
            "Name": name,
            "Username": username,
            "Email": email,
            "Uid": uid,
            "IsAdmin": false,
            "BgPhotoUrl":"https://img.freepik.com/free-photo/empty-wooden-blurred-nature-backdrop-wood-table-top_43620-5.jpg?size=626&ext=jpg",
            "ProfilePhotoUrl":
                "https://freesvg.org/img/abstract-user-flat-4.png",
            "TagLine": "Husband,Father,Hard Worker",
            "Profession": "AppUser",
            "Location": "California, USA",
            "DOB": "01/01/2000",
            "PhoneNumber": "0000000000",
          }
        }, SetOptions(merge: true))
        .then((value) => print("User Details Added"))
        .catchError((error) => print("Failed to add user: $error"));

    return;
  }

  // Update UserDetails
  Future<void> updateUserDetails(
      name, tagline, profession, date, location, imageUrl, bgImageUrl) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();

    userCollection
        .doc(uid)
        .set({
          "Info": {
            "Name": name,
            "TagLine": tagline,
            "Profession": profession,
            "Location": location,
            "DOB": date,
            "ProfilePhotoUrl" :imageUrl,
            "BgPhotoUrl":bgImageUrl,
          }
        }, SetOptions(merge: true))
        .then((value) => print("User Details Updated"))
        .catchError((error) => print("Failed to Update user: $error"));

    return;
  }

}
