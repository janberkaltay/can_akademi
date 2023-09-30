import 'package:can_mobil/models/lgsInfoDetail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LgsInfo extends StatelessWidget {
  const LgsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).textScaleFactor * 14;
    return Scaffold(
      backgroundColor: const Color(0xFFFFAA00),
      appBar: AppBar(
        title: const Text('LGS Hakkında'),
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
          stream: FirebaseFirestore.instance.collection('LGSInfo').snapshots(),
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
                final document = documents[index];
                final title = document['title'] as String;
                final content = document['content'] as String;
                final content2 = document['content2'] as String;
                final content3 = document['content3'] as String;
                final content4 = document['content4'] as String;
                final content5 = document['content5'] as String;
                final content6 = document['content6'] as String;
                final content7 = document['content7'] as String;
                final content8 = document['content8'] as String;
                final content9 = document['content9'] as String;
                final content10 = document['content10'] as String;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LGSInfoDetail(
                          title: title,
                          content: content,
                          content2: content2,
                          content3: content3,
                          content4: content4,
                          content5: content5,
                          content6: content6,
                          content7: content7,
                          content8: content8,
                          content9: content9,
                          content10: content10,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
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
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 8, top: 8),
                              height: 90,
                              child: const CircleAvatar(
                                radius: 38,
                                backgroundColor: Color(0xFFFFAA00),
                                backgroundImage: AssetImage('assets/lgs3.png'),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    title,
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Yazıyı Okumak İçin Tıklayınız',
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
      ),
    );
  }
}
