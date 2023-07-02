import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

Future<void> handleBackGroundNotification(RemoteMessage message) async {
  print(message.notification?.title);
}

class FirebaseNotificatios {
  final messaging = FirebaseMessaging.instance;

  Future<String> getAdminToken() async {
    try {
      QuerySnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .where('email',
              isEqualTo: 'admin@gmail.com') // Replace with your condition
          .limit(1)
          .get();

      if (adminSnapshot.docs.isNotEmpty) {
        String token = adminSnapshot.docs[0].get('token');
        return token;
      } else {
        print('Admin document not found');
        return '';
      }
    } catch (error) {
      print('Error retrieving admin token: $error');
      return '';
    }
  }

  Future<String> getUserToken(String uid) async {

   
    try {
      final adminSnapshot = await FirebaseFirestore.instance
          .collection('user_Tb')
          .doc(uid)
          .get();

      if (adminSnapshot.exists) {

        
        String token =  await adminSnapshot.get('token');
        return token;
      } else {
        print('Admin document not found');
        return '';
      }
    } catch (error) {
      print('Error retrieving admin token: $error');
      return '';
    }
  }

  Future<String> getDoctorToken(String uid) async {

   
    try {
      final adminSnapshot = await FirebaseFirestore.instance
          .collection('doctor')
          .doc(uid)
          .get();

      if (adminSnapshot.exists) {

        
        String token =  await adminSnapshot.get('token');
        return token;
      } else {
        print('Admin document not found');
        return '';
      }
    } catch (error) {
      print('Error retrieving admin token: $error');
      return '';
    }
  }

  Future<void> initNotification() async {
    await messaging.requestPermission();

    FirebaseMessaging.onBackgroundMessage(handleBackGroundNotification);
  }

  Future<void> sendNotification({String ? deviceToken,String ? body,String ? title}) async {
    const url = 'https://fcm.googleapis.com/fcm/send';
    const serverKey =
        'AAAADEzcw08:APA91bHWekgq7C3BcysQIhF3fq-MxMZ-H1uYkzmVH_qPExWLCLm8gNpjgp9I46ENMW364EMOE9eeosTTt_4bW7E5qevyzLhE2gR3JeFVh8psGzJsqaC2P8qvZtCTbYajgTUyudclxtvE'; // Replace with your FCM server key

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final message = {
      'priority': 'high',
      'data': <String, dynamic>{
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'status': 'done',
        'body': body,
        'title':  title,
      },
      "notification": <String, dynamic>{
        "title": title,
        "body":  body,
        "android_channel_id": "high_importance_channel"
      },
      'to': deviceToken,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Error: ${response.body}');
    }
  }
}
