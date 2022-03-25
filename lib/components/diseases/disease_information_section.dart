/*
* IT19180526 (S.A.N.L.D. Chandrasiri)
*/

import 'package:flutter/material.dart';

class DiseaseInformationSection extends StatelessWidget {
  final String title;
  final String information;

  const DiseaseInformationSection(
      {Key? key, required this.title, required this.information})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5),
            Text(
              information,
              style: const TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
