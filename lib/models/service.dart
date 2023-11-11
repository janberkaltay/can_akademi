import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

class FirebaseNotificationService {
  late final FirebaseMessaging messaging;

  void settingNotification() async {
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void connectNotification() async {
    await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    settingNotification();
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      if (event.notification != null) {
        final notification = event.notification!;
        Grock.snackBar(
          title: notification.title ?? '',
          description: notification.body ?? '',
          trailing: notification.android?.imageUrl == null
              ? null
              : Image.network(
            notification.android!.imageUrl!,
            width: 60,
            height: 60,
          ),
          opacity: 0.5,
          position: SnackbarPosition.top,
        );
      }
    });
    messaging.getToken().then((value) => log("Token: $value", name: "FCM Token"));
  }

  static Future<void> backgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    if (kDebugMode) {
      print("Handling a background message: ${message.messageId}");
    }
  }
}
