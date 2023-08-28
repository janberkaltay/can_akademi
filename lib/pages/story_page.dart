import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {
  final List<String> storyImageUrls;
  final int initialIndex;

  const StoryPage({
    Key? key,
    required this.storyImageUrls,
    required this.initialIndex,
  }) : super(key: key);

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late PageController _pageController;
  int _currentIndex = 0;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed && !_isPaused) {
          _goToNextStory();
        }
      });

    _animationController.addListener(() {
      setState(() {});
    });

    _pageController = PageController(initialPage: _currentIndex);

    _startAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _animationController.forward().whenComplete(() {
      _goToNextStory();
    });
  }

  void _goToNextStory() {
    if (_currentIndex < widget.storyImageUrls.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
      _animationController.reset();
      _startAnimation();
    } else {
      Navigator.pop(context);
    }
  }

  void _goToPreviousStory() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
      _animationController.reset();
      _startAnimation();
    }
  }

  void _pauseAnimation() {
    setState(() {
      _isPaused = true;
    });
    _animationController.stop();
  }

  void _resumeAnimation() {
    setState(() {
      _isPaused = false;
    });
    _animationController.forward().whenComplete(() {
      _goToNextStory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFA000),
      body: GestureDetector(
        onTap: _goToNextStory,
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            _goToNextStory();
          } else if (details.primaryVelocity! > 0) {
            _goToPreviousStory();
          }
        },
        onLongPress: _pauseAnimation,
        onLongPressUp: _resumeAnimation,
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.storyImageUrls.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Image.network(
                    widget.storyImageUrls[index],
                    fit: BoxFit.contain,
                  ),
                );
              },
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
                _animationController.reset();
                _startAnimation();
              },
            ),
            Positioned(
              top: 80,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: _animationController.value,
                    backgroundColor: Colors.grey,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
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
