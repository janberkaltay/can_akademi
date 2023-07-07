import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SlideshowContainer extends StatelessWidget {
  const SlideshowContainer({Key? key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return CarouselSlider(
            items: [
              Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/slide/image1.jpeg', fit: BoxFit.contain),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 82),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black.withOpacity(1),
                        ),
                        child: const Text(
                          'Eğitimin ve İlginin Merkezi',
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14)
                    ],
                  ),
                ],
              ),
              Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/slide/image2.jpeg', fit: BoxFit.contain),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 82),
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black.withOpacity(1),
                        ),
                        child: const Text(
                          'Eğitimin ve İlginin Merkezi',
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14)
                    ],
                  ),
                ],
              ),
              Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/slide/image4.jpeg', fit: BoxFit.contain),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 82),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black.withOpacity(1),
                        ),
                        child: const Text(
                          'Eğitimin ve İlginin Merkezi',
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14)
                    ],
                  ),
                ],
              ),
            ],
            options: CarouselOptions(
              scrollPhysics: const PageScrollPhysics(),
              height: constraints.maxWidth,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              enableInfiniteScroll: true,
            ),
          );
        },
      ),
    );
  }
}
