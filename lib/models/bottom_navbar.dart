import 'package:can_mobil/pages/exam_results.dart';
import 'package:can_mobil/pages/home_page.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  final int currentPageIndex;

  const BottomNavbar({super.key, required this.currentPageIndex});

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int previousPageIndex = -1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      height: 72,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 1.5,
                width: MediaQuery.of(context).size.width * 0.5,
                color: widget.currentPageIndex == 0
                    ? const Color(0xFFFFA000)
                    : Colors.grey,
              ),
              Container(
                height: 1.5,
                width: MediaQuery.of(context).size.width * 0.5,
                color: widget.currentPageIndex == 1
                    ? const Color(0xFFFFA000)
                    : Colors.grey,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        size: 26,
                        color: widget.currentPageIndex == 0
                            ? const Color(0xFFFFA000)
                            : Colors.grey,
                      ),
                      onPressed: widget.currentPageIndex == 0
                          ? null
                          : () {
                              if (previousPageIndex != 0) {
                                previousPageIndex = widget.currentPageIndex;
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                    ),
                    Text(
                      'Anasayfa',
                      style: TextStyle(
                        color: widget.currentPageIndex == 0
                            ? const Color(0xFFFFA000)
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 38),
                child: Transform.translate(
                  offset: const Offset(0, -35),
                  child: RotationTransition(
                    turns: _animation,
                    child: Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFA000),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset('assets/Can logo.png'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 16,
                ),
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.bar_chart,
                        size: 26,
                        color: widget.currentPageIndex == 1
                            ? const Color(0xFFFFA000)
                            : Colors.grey,
                      ),
                      onPressed: widget.currentPageIndex == 1
                          ? null
                          : () {
                              if (previousPageIndex != 1) {
                                previousPageIndex = widget.currentPageIndex;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ExamResults(),
                                  ),
                                );
                              }
                            },
                    ),
                    Text(
                      'Sınav Sonuçları',
                      style: TextStyle(
                        color: widget.currentPageIndex == 1
                            ? const Color(0xFFFFA000)
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
