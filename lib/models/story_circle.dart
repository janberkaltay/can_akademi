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
    double fontSize = MediaQuery.of(context).textScaleFactor * 11;

    List<String> imageNameParts = imageName.split('.');
    String imageNameWithoutExtension = imageNameParts.first;

    return Column(
      children: [
        GestureDetector(
          onTap: () => onTap(imageUrl),
          child: const Padding(
            padding: EdgeInsets.only(left: 8),
            child: SizedBox(
              height: 70,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/logoo.jpg'),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: Text(
                imageNameWithoutExtension,
                style: TextStyle(
                  fontSize: fontSize,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
