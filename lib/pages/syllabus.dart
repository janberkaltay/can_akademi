import 'dart:io';
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
    final results = await _firebaseFirestore.collection('programs').get();

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
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFA000),
        flexibleSpace: Container(decoration: const BoxDecoration()),
        title: const Text('Ders Programı'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: pdfData.length * 2 - 1, // Account for dividers
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return const Divider(
              height: 1,
              thickness: 1.5,
              color: Color(0xFFFFA000),
            ); // Add a Divider widget
          }

          final itemIndex = index ~/ 2; // Adjust the item index
          return ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    PdfViewerScreen(pdfUrl: pdfData[itemIndex]['url']),
              ));
            },
            contentPadding: const EdgeInsets.all(8.0),
            title: Text(
              pdfData[itemIndex]['name'],
              style: const TextStyle(fontSize: 16),
            ),
            subtitle: Text(
              'Yüklenme tarihi: ${DateFormat('dd.MM.yyyy').format(pdfData[itemIndex]['uploadDate'])}',
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            leading: const Icon(
              Icons.picture_as_pdf,
              color: Colors.red,
              size: 50,
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
