import 'package:flutter/material.dart';

class StoryCircle extends StatelessWidget {
  final String imageUrl;
  final String imageName;
  final void Function(String) onTap;

  const StoryCircle({
    Key? key,
    required this.imageUrl,
    required this.onTap,
    required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> imageNameParts = imageName.split('.');
    String imageNameWithoutExtension = imageNameParts.first;

    return Column(
      children: [
        GestureDetector(
          onTap: () => onTap(imageUrl),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 6, top: 6),
            child: Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/logoo.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:8),
              child: Text(
                imageNameWithoutExtension,
                style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20,)
      ],
    );
  }
}
