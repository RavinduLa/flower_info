import 'package:flutter/material.dart';

import '../../components/diseases/disease_item_tile.dart';
import '../../data/disease_data.dart';
import '../../models/disease_model.dart';

class Diseases extends StatelessWidget {
  final List<Disease> diseases = diseaseList;

  const Diseases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: diseases.length,
        itemBuilder: (context, index) {
          return DiseaseItemTile(disease: diseases[index]);
        },
      ),
    );
  }
}
