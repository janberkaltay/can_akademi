import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/EvaluationDetail.dart';

class EvaluationScreen extends StatelessWidget {
  const EvaluationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).textScaleFactor * 12;
    return Scaffold(
        backgroundColor: const Color(0xFFFFAA00),
        appBar: AppBar(
          title: const Text('Aylık Öğretmen Değerlendirmeleri'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFFFFAA00),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('evaluation').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Hata: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final List<DocumentSnapshot> documents = snapshot.data!.docs;

              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: documents.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> data =
                      documents[index].data() as Map<String, dynamic>;
                  String name = data['name'];
                  String title = data['title'];
                  String content = data['content'];
                  String content2 = data['content2'];
                  String content3 = data['content3'];
                  String content4 = data['content4'];
                  Timestamp timestamp = data['date'];

                  DateTime dateTime = timestamp.toDate();
                  String formattedDate =
                      DateFormat('dd.MM.yyyy').format(dateTime);

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EvaluationDetailScreen(
                            name: name,
                            title: title,
                            content: content,
                            content2: content2,
                            content3: content3,
                            content4: content4,
                            formattedDate: formattedDate,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                      color: const Color(0xF3EEEEEE),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 16,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(bottom: 8, top: 8),
                                height: 90,
                                child: const CircleAvatar(
                                  radius: 38,
                                  backgroundColor: Color(0xFFFFAA00),
                                  backgroundImage:
                                      AssetImage('assets/Can logo.png'),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0x5C2F2F2F),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    formattedDate,
                                    style: TextStyle(
                                      fontSize: fontSize,
                                      color: const Color(0x5C2F2F2F),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Değerlendirmeyi görmek',
                                        style: TextStyle(
                                            color: Color(0xFFFFAA00),
                                            fontSize: 12),
                                      ),
                                      Text(
                                        'için tıklayınız',
                                        style: TextStyle(
                                            color: Color(0xFFFFAA00),
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ));
  }
}
/*
showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Column(
                            children: [
                              Container(
                                height: 80,
                                color: Colors.white,
                                child: const CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Color(0xFFFFAA00),
                                  backgroundImage:
                                      AssetImage('assets/Can logo.png'),
                                ),
                              ),
                              Text(name),
                              Text(
                                '$formattedDate tarihinde yazıldı',
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          content: SingleChildScrollView(child: Text(content)),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Kapat'),
                            ),
                          ],
                        ),
                      );
 */
