import 'package:flutter/material.dart';

class EvaluationDetailScreen extends StatelessWidget {
  final String name;
  final String title;
  final String content;
  final String content2;
  final String content3;
  final String content4;
  final String formattedDate;

  const EvaluationDetailScreen({super.key,
    required this.name,
    required this.title,
    required this.content,
    required this.content2,
    required this.content3,
    required this.content4,
    required this.formattedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFAA00),
      appBar: AppBar(
        title: const Text('Değerlendirme Detayı'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFFFAA00),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                formattedDate,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text(
                content,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Text(
                content2,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Text(
                content3,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Text(
                content4,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      )
    );
  }
}