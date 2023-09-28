import 'package:can_mobil/models/countdown.dart';
import 'package:can_mobil/models/hidden_navbar.dart';
import 'package:can_mobil/models/service.dart';
import 'package:can_mobil/pages/lgs_info.dart';
import 'package:can_mobil/pages/questions_page.dart';
import 'package:can_mobil/pages/story_page.dart';
import 'package:can_mobil/pages/weekly_programs.dart';
import 'package:flutter/foundation.dart';
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
      if (kDebugMode) {
        print('Error loading story image URLs: $e');
      }
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
        backgroundColor: const Color(0xFFFFAA00),
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
              const Column(
                children: [
                  Text(
                    "Can Mobil'e erişebilmek için ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "internet bağlantın olması gerekir.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
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
      bottomNavigationBar: const BottomNavbar(currentPageIndex: 0),
      backgroundColor: Colors.white,
      endDrawer: const NavBar(),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: Color(0xFFFFA000),
            centerTitle: false,
            title: Column(
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
            pinned: false, // App bar'ın ekranın üstünde sabit kalmasını sağlar
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFA000),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  height: 110,
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
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LgsInfo(),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.green,
                        color: const Color(0xFFFAC85F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              'LGS Hakkında Bilinmesi Gerekenler',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFAA00),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.arrow_circle_right_outlined,
                                  size: 34,
                                  color: Colors.black,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
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
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200],
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
                                  // builder: (context) => const WeeklyProgram(),
                                  builder: (context) => const WeeklyProgram(),
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFAA00),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Göster',
                                        style: TextStyle(
                                            color: Colors.black,
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
                          color: Colors.grey[200],
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
                                  builder: (context) => const QuestionsPage(),
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFAA00),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Göster',
                                        style: TextStyle(
                                            color: Colors.black,
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
                        "LGS'ye Kaç Gün Kaldı",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  child: CountdownPage(),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ]))
        ],
      ),
    );
  }
}
