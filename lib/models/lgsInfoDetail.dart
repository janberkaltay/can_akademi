import 'package:flutter/material.dart';

class LGSInfoDetail extends StatelessWidget {
  final String title;
  final String content;
  final String content2;
  final String content3;
  final String content4;
  final String content5;
  final String content6;
  final String content7;
  final String content8;
  final String content9;
  final String content10;

  const LGSInfoDetail(
      {super.key,
      required this.title,
      required this.content,
      required this.content2,
      required this.content3,
      required this.content4,
      required this.content5,
        required this.content6,
        required this.content7,
        required this.content8,
        required this.content9,
        required this.content10,

      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFAA00),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            title,
            maxLines: 2,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        backgroundColor: const Color(0xFFFFAA00),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                content,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                content2,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                content3,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                content4,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                content5,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                content6,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                content7,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                content8,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                content9,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                content10,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
