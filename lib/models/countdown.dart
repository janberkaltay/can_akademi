import 'dart:async';
import 'package:flutter/material.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({super.key});

  @override
  CountdownPageState createState() => CountdownPageState();
}

class CountdownPageState extends State<CountdownPage> {
  DateTime examDate = DateTime(2024, 6, 2, 6, 30, 0);
  String remainingTime = '';

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime = calculateRemainingTime();
      });
    });
  }

  String calculateRemainingTime() {
    DateTime now = DateTime.now();
    Duration difference = examDate.difference(now);
    int days = difference.inDays;
    int hours = difference.inHours.remainder(24);
    int minutes = difference.inMinutes.remainder(60);
    int seconds = difference.inSeconds.remainder(60);

    return '$days gün $hours saat $minutes dakika $seconds saniye';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.17,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/lgs2.jpeg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            const Color(0xFFFFAA00).withOpacity(0.4),
            BlendMode.dstATop,
          ),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      width: MediaQuery.of(context).size.width - 24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            '2024 LGS Sınavına Kalan Süre:',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          Text(
            remainingTime,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
