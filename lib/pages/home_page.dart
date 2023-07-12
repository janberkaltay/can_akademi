import 'package:can_mobil/models/hidden_navbar.dart';
import 'package:can_mobil/models/service.dart';
import 'package:can_mobil/models/teachers_evaluation.dart';
import 'package:can_mobil/pages/questions_page.dart';
import 'package:can_mobil/pages/story_page.dart';
import 'package:can_mobil/pages/weekly_programs.dart';
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
  final _service = FirebaseNotificationService();
  bool showSplashScreen = true;
  List<String> storyImageUrls = [];
  List<String> storyImageNames = [];

  @override
  void initState() {
    super.initState();
    loadStoryImageUrls();
    _service.connectNotification();
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
              const SizedBox(height: 50),
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
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      bottomNavigationBar: BottomNavbar(currentPageIndex: 0),
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: const Color(0xFFFFA000),
              centerTitle: false,
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Merhaba! Can Mobil'e",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Hoş geldin!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              elevation: 0,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFFA000),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              height: 100,
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
      endDrawer: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 10),
                  child: Text(
                    'Hizmetlerimiz',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFAA00),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: MediaQuery.of(context).size.width * 0.5 - 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/Calendar-rafiki (1).png',
                                  height: 110,
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Haftalık Program',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Image.asset('assets/haftalık program.png'),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const WeeklyProgram(),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Göster',
                                    style: TextStyle(
                                        color: Color(0xFFFFAA00),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFAA00),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: MediaQuery.of(context).size.width * 0.5 - 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/Seminar-rafiki.png',
                                  height: 110,
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Ek Sorular',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Image.asset('assets/ek sorular.png'),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const WeeklyProgram(),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Göster',
                                    style: TextStyle(
                                        color: Color(0xFFFFAA00),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 10, top: 10),
                  child: Text(
                    'Aylık Öğretmen Değerlendirmeleri',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: EvaluationScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
