import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'authentication_helper.dart';
import 'get_user_data.dart';

class StoreRegisterData extends StatefulWidget {

  const StoreRegisterData({Key? key, required this.password, required this.name, required this.username}) : super(key: key);
  final String password, name, username;

  @override
  State<StoreRegisterData> createState() => _StoreRegisterDataState();
}

class _StoreRegisterDataState extends State<StoreRegisterData> {

  Future<String> getData() async{
    String temp = "yash";
    await AuthenticationHelper().storeUserDetails(
        widget.password, widget.name, widget.username);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GetUserData(),
      ),
    );
    return temp;
  }

  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return FutureBuilder<String>(
      future: getData(),
      builder:
          (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasError) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return GetUserData();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
