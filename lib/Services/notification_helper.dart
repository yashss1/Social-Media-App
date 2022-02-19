import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class NotificationHelper {
  Future<void> getTokenForFollowing(String otherUID) async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;

    var _doc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(otherUID)
        .get();

    var _doc1 =
        await FirebaseFirestore.instance.collection("Users").doc(uid).get();
    String msg = "Following Notification";

    bool docStatus = _doc.exists;
    bool docStatus1 = _doc1.exists;
    if (docStatus == true && docStatus1 == true) {
      msg =
          "${_doc1['Info']['Name']} : (@${_doc1['Info']['Username']}) started following you";
      callOnFcmApiSendPushNotifications(
          [_doc['Info']['Token']], msg, "Signature");
    }
  }

  Future<void> getTokenForChatSent(String otherUID, String msg) async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;

    var _doc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(otherUID)
        .get();

    var _doc1 =
    await FirebaseFirestore.instance.collection("Users").doc(uid).get();

    bool docStatus = _doc.exists;
    bool docStatus1 = _doc1.exists;
    if (docStatus == true && docStatus1 == true) {
     callOnFcmApiSendPushNotifications(
          [_doc['Info']['Token']], msg, "${_doc1['Info']['Name']}: @${_doc1['Info']['Username']}");
    }
  }

  callOnFcmApiSendPushNotifications(
      List<String> userToken, String msg, String name) async {
    print("Notification : ${userToken[0]} ${msg} - ${name}");

    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "registration_ids": userToken,
      "collapse_key": "type_a",
      "notification": {
        "title": name,
        "body": msg,
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'Bearer AAAAM0kUFpU:APA91bFmtrH_A2td19Eb78v-XQjeNtSkoPny0mjtyrHzT_bWnGA2zXOS31oGIHGHK4Q8bN7KmAVDilQCmNMrb9Z1cL1A2AnaZNPMOrYsVE9d8D58flmONJCJdpSKEFccc3WhX7XAgIaD'
    };

    try {
      final response = await http.post(Uri.parse(postUrl),
          body: json.encode(data),
          encoding: Encoding.getByName('utf-8'),
          headers: headers);

      if (response.statusCode == 200) {
        // on success do sth
        print('test ok push CFM');
        return true;
      } else {
        print(' CFM error${response.reasonPhrase}');
        // on failure do sth
        return false;
      }
    } catch (e) {
      print('exception$e');
    }
  }
}
