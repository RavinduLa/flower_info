import 'package:flutter/material.dart';

class FlowerInfoContainer extends StatelessWidget {
  const FlowerInfoContainer(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.fontStyle})
      : super(key: key);

  final String title;
  final String subtitle;
  final FontStyle fontStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: 15, fontStyle: fontStyle),
            ),
          ],
        ),
      ),
    );
  }
}
