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
    double fontSize = MediaQuery.of(context).textScaleFactor * 12;

    List<String> imageNameParts = imageName.split('.');
    String imageNameWithoutExtension = imageNameParts.first;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => onTap(imageUrl),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.yellow, Colors.white],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          imageNameWithoutExtension,
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
