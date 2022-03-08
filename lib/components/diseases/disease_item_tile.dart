import 'package:flutter/material.dart';

import '../../models/disease_model.dart';

class DiseaseItemTile extends StatelessWidget {
  final Disease disease;

  const DiseaseItemTile({Key? key, required this.disease}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              child: Image.network(
                disease.image,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
