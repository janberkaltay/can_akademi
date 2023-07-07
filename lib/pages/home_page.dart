import 'package:can_mobil/models/hidden_navbar.dart';
import 'package:can_mobil/pages/exam_results.dart';
import 'package:can_mobil/pages/story_page.dart';
import 'package:can_mobil/pages/syllabus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/bottom_navbar.dart';
import '../models/story_circle.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showSplashScreen = true;
  List<String> storyImageUrls = [];
  List<String> storyImageNames = [];

  @override
  void initState() {
    super.initState();
    loadStoryImageUrls();
  }

  Future<void> loadStoryImageUrls() async {
    try {
      final ListResult result =
          await FirebaseStorage.instance.ref('stories').listAll();

      final List<String> urls = await Future.wait(
        result.items.map((Reference ref) => ref.getDownloadURL()),
      );

      final List<String> imageNames = result.items.map((Reference ref) {
        String fullPath = ref.fullPath;
        List<String> pathSegments = fullPath.split('/');
        String imageName = pathSegments.last;
        return imageName;
      }).toList();

      setState(() {
        storyImageUrls = urls;
        storyImageNames = imageNames;
        showSplashScreen = false;
      });
    } catch (e) {
      print('Error loading story image URLs: $e');
    }
  }

  void _openStory(String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryPage(
          storyImageUrls: storyImageUrls,
          initialIndex: storyImageUrls.indexOf(imageUrl),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (showSplashScreen) {
      return Scaffold(
        backgroundColor: const Color(0xFFFFA000),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/Can logo.png'),
              const CircularProgressIndicator(
                color: Colors.black,
              ),
              const SizedBox(height: 50),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.copyright,
                    color: Colors.black,
                    size: 20,
                  ),
                  Text(
                    'Powered By Endless Software',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      bottomNavigationBar: BottomNavbar(
        currentPageIndex: 0,
      ),
      backgroundColor: const Color(0xFFFFA000),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: const Color(0xFFFFA000),
              centerTitle: false,
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Merhaba! Can Mobil'e",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Hoş geldin!',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              elevation: 0,
            ),
            Container(
              color: const Color(0xFFFFA000),
              height: 140,
              child: ListView.builder(
                itemCount: storyImageUrls.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  String imageUrl = storyImageUrls[index];
                  String imageName = storyImageNames[index];
                  return StoryCircle(
                    onTap: _openStory,
                    imageUrl: imageUrl,
                    imageName: imageName,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      endDrawer: NavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 800,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Text(
                          'Hizmetlerimiz',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 240,
                        width: MediaQuery.of(context).size.width * 0.5 - 16,
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFA000),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 10),
                            Image.asset(
                              'assets/ders.png',
                              width: 150,
                              height: 60,
                            ),
                            const Text(
                              'Ders Programı',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                                'Anlık olarak erişilebilen ders programımız ile birlikte öğretmenlerimiz   ve öğrencilerimize zamanlarından tasarruf sağlıyoruz.',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12)),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Syllabus(),
                                ));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    32,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Göster',
                                        style: TextStyle(
                                            color: Color(0xFFFFA000),
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        height: 240,
                        width: MediaQuery.of(context).size.width * 0.5 - 16,
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFA000),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Image.asset(
                              'assets/sorular.png',
                              width: 150,
                              height: 60,
                            ),
                            const Text(
                              'Ek Sorular',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                                'Ek sorular, hocalarımız tarafından öğrencilerin öğrenme sürecini derinleştirmek ve daha fazla soru görmeleri için değerli fırsatlar sunar.',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12)),
                            const SizedBox(height: 13),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ExamResults(),
                                ));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    32,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Göster',
                                        style: TextStyle(
                                            color: Color(0xFFFFA000),
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Text(
                          'Aylık Öğretmen Değerlendirmeleri',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
