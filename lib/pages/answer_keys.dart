import 'dart:io';
import 'package:can_mobil/models/bottom_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'pdf_view_page.dart';

class AnswerKeys extends StatefulWidget {
  const AnswerKeys({Key? key}) : super(key: key);

  @override
  State<AnswerKeys> createState() => _AnswerKeysState();
}

class _AnswerKeysState extends State<AnswerKeys> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> pdfData = [];

  Future<String?> uploadPdf(String fileName, File file) async {
    final reference = FirebaseStorage.instance.ref().child("pdfs/$fileName");
    final uploadTask = reference.putFile(file);
    await uploadTask.whenComplete(() {});
    final downloadLink = await reference.getDownloadURL();

    await _firebaseFirestore.collection('answerKeys').add({
      "name": fileName,
      "url": downloadLink,
      "uploadDate": DateTime.now(),
    });

    return downloadLink;
  }

  void pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (pickedFile != null) {
      String fileName = pickedFile.files[0].name;
      File file = File(pickedFile.files[0].path!);
      final downloadLink = await uploadPdf(fileName, file);

      if (kDebugMode) {
        print('Pdf Uploaded Successfully $downloadLink');
      }
    }
  }

  void getAllPdf() async {
    final results = await _firebaseFirestore
        .collection('answerKeys')
        .orderBy('uploadDate', descending: true)
        .get();

    pdfData = results.docs.map((e) {
      Map<String, dynamic> data = e.data();
      data["uploadDate"] = e.data()["uploadDate"].toDate();
      return data;
    }).toList();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFA000),
      bottomNavigationBar: const BottomNavbar(
        currentPageIndex: 1,
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFFA000),
//        flexibleSpace: Container(decoration: const BoxDecoration()),
        title: const Text('Cevap Anahtarları'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ListView.builder(
          itemCount: pdfData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PdfViewerScreen(pdfUrl: pdfData[index]['url']),
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xF3EEEEEE),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          FontAwesomeIcons.filePdf,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          pdfData[index]['name'].split('.').first,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFFFA000),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                  'Yüklenme tarihi ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(DateFormat('dd.MM.yyyy')
                                    .format(pdfData[index]['uploadDate'])),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: pickFile,
        child: const Icon(FontAwesomeIcons.filePdf, color: Colors.white,),
      ),
       */
    );
  }
}