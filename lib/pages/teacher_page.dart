import 'package:can_mobil/models/teachers_evaluation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/bottom_navbar.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({Key? key}) : super(key: key);

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(
        currentPageIndex: 2,
      ),
      backgroundColor: const Color(0xFFFFAA00),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFAA00),
        title: const Text(
          'CAN KADROMUZ',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('teachers').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Hata: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> teacher =
                    document.data() as Map<String, dynamic>;

                return TeacherCard(
                  teacherName: teacher['name'],
                  teacherTitle: teacher['title'],
                  teacherBio: teacher['bio'],
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class TeacherCard extends StatelessWidget {
  final String teacherName;
  final String teacherTitle;
  final String? teacherBio;

  const TeacherCard({
    required this.teacherName,
    required this.teacherTitle,
    required this.teacherBio,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: const Color(0xF3EEEEEE),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 8,
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 8, top: 8),
              height: 80,
              child: const CircleAvatar(
                radius: 28,
                backgroundColor: Color(0xFFFFAA00),
                backgroundImage: AssetImage('assets/Can logo.png'),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  teacherName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  teacherTitle,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Color(0x5C2F2F2F),
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Column(
                      children: [
                        Container(
                          height: 100,
                          color: Colors.white,
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundColor: Color(0xFFFFAA00),
                            backgroundImage: AssetImage('assets/Can logo.png'),
                          ),
                        ),
                        Text(teacherName),
                      ],
                    ),
                    content: Text(teacherBio!),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Kapat'),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFAA00),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Özgeçmiş',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
