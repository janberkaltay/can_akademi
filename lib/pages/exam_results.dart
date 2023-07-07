import 'dart:io';
import 'package:can_mobil/models/bottom_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'pdf_view_page.dart';

class ExamResults extends StatefulWidget {
  const ExamResults({Key? key}) : super(key: key);

  @override
  State<ExamResults> createState() => _ExamResultsState();
}

class _ExamResultsState extends State<ExamResults> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> pdfData = [];

  Future<String?> uploadPdf(String fileName, File file) async {
    final reference = FirebaseStorage.instance.ref().child("pdfs/$fileName");
    final uploadTask = reference.putFile(file);
    await uploadTask.whenComplete(() {});
    final downloadLink = await reference.getDownloadURL();

    await _firebaseFirestore.collection('pdfs').add({
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
    final results = await _firebaseFirestore.collection('pdfs').get();

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
      bottomNavigationBar: BottomNavbar(
        currentPageIndex: 1,
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFA000),
        flexibleSpace: Container(decoration: const BoxDecoration()),
        title: const Text('Haftanın Sınav Sonuçları'),
        centerTitle: false,
      ),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
                  border: Border.all(),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.picture_as_pdf,
                      color: Colors.red,
                      size: 50,
                    ),
                    Text(
                      pdfData[index]['name'],
                      style: const TextStyle(fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Yüklenme tarihi: ${DateFormat('dd.mm.yyyy').format(pdfData[index]['uploadDate'])}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickFile,
        child: const Icon(Icons.upload_file),
      ),
    );
  }
}
