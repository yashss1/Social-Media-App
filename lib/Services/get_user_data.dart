import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/DashBoard%20Screens/home.dart';
import 'package:social_media/DashBoard%20Screens/home_page.dart';
import 'package:social_media/Services/user_details.dart';

class GetUserData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    String documentId = uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          UserDetails.name = data['Info']['Name'].toString();
          UserDetails.email = data['Info']['Email'].toString();
          UserDetails.username = data['Info']['Username'].toString();
          UserDetails.password = data['Info']['Password'].toString();
          UserDetails.isAdmin = data['Info']['IsAdmin'];
          UserDetails.profilePhotoUrl =
              data['Info']['ProfilePhotoUrl'].toString();
          UserDetails.uid = data['Info']['Uid'];

          return HomePage();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
