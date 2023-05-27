import 'dart:html';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

bool checkIfMobile(){
  final userAgent = window.navigator.userAgent.toString().toLowerCase();
  if(userAgent.contains('android') || userAgent.contains('iphone')){
    return true;
  }
  return false;
}

Future<void> getPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true
  );
  print('User granted permission: ${settings.authorizationStatus}');
} 

void messageListener(BuildContext context){
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if(message.notification != null){
      showDialog(
        context: context,
        builder: (BuildContext context) {

          return SimpleDialog(
            title: Text(message.notification!.title ?? ''),
            titlePadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.all(10),
          );
          
        }
      );
    }
  });
}