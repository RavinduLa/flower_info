import 'package:flower_info/models/disease_model_id.dart';
import 'package:flutter/material.dart';

import '../../models/disease_model.dart';

class DiseaseItemTile extends StatelessWidget {
  final DiseaseWithId disease;

  const DiseaseItemTile({Key? key, required this.disease}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  disease.image,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(disease.name),
          ],
        ),
      ),
    );
  }
}
