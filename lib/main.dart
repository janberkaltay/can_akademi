import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      debugShowCheckedModeBanner: false,
      title: 'Can Mobil',
      theme: ThemeData(
        primaryColor: const Color(0xFFFFA000),
        primarySwatch: Colors.orange,
        progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.white),
      ),
      home: Builder(
        builder: (context) {
          return const HomePage();
        },
      ),
    );
  }
}

