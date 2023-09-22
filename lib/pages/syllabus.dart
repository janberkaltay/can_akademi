import 'dart:io';
import 'package:can_mobil/models/bottom_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'pdf_view_page.dart';

class Syllabus extends StatefulWidget {
  const Syllabus({Key? key}) : super(key: key);

  @override
  State<Syllabus> createState() => _SyllabusState();
}

class _SyllabusState extends State<Syllabus> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> pdfData = [];

  Future<String?> uploadPdf(String fileName, File file) async {
    final reference =
        FirebaseStorage.instance.ref().child("programs/$fileName");
    final uploadTask = reference.putFile(file);
    await uploadTask.whenComplete(() {});
    final downloadLink = await reference.getDownloadURL();

    await _firebaseFirestore.collection('programs').add({
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
        debugPrint('Pdf Uploaded Successfully $downloadLink');
      }
    }
  }


  void getAllPdf() async {
    final results = await _firebaseFirestore
        .collection('programs')
        .orderBy('uploadDate', descending: true) // Sıralamayı tarihe göre yapar, en yeni en üstte olur
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFFA000),
        flexibleSpace: Container(decoration: const BoxDecoration()),
        title: const Text('Ders Programı'),
        centerTitle: true,
      ),
      bottomNavigationBar: const BottomNavbar(currentPageIndex: 2),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: GridView.builder(
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
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xF3EEEEEE),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 4),
                      const Icon(
                        Icons.picture_as_pdf,
                        color: Colors.red,
                        size: 50,
                      ),
                      Text(
                        pdfData[index]['name']
                            .split('.')
                            .first, // Remove the file extension
                        style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:  const Color(0xFFFFA000),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8,),
                                const Text(
                                  'Yüklenme tarihi ',
                                  style:
                                  TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
                                ),
                                Text(DateFormat('dd.MM.yyyy').format(pdfData[index]['uploadDate'])),
                                const SizedBox(height: 8,),
                              ],
                            ),
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
        child: const Icon(Icons.upload_file),
      ),

       */
    );
  }
}
