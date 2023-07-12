import 'package:can_mobil/models/service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grock/grock.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(
      FirebaseNotificationService.backgroundMessage);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Grock.navigationKey,
      scaffoldMessengerKey: Grock.scaffoldMessengerKey,
      title: 'Can Mobil',
      theme: ThemeData(
        primaryColor: const Color(0xFFFFA000),
        primarySwatch: Colors.orange,
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: Colors.white),
      ),
      home: const HomePage(),
    );
  }
}