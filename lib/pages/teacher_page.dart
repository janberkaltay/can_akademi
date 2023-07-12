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
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
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
/* margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), )*/
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            content: SingleChildScrollView(child: Text(teacherBio!)),
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xF3EEEEEE),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              height: 80,
              child: const CircleAvatar(
                radius: 32,
                backgroundColor: Color(0xFFFFAA00),
                backgroundImage: AssetImage('assets/Can logo.png'),
              ),
            ),
            const SizedBox(width: 20),
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
                const Text(
                  'Özgeçmişi görmek için tıklayın',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFFFAA00),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
