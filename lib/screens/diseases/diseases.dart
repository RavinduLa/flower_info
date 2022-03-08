import 'package:flower_info/components/diseases/disease_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flower_info/models/disease_model.dart';
import '../../data/disease_data.dart';

class Diseases extends StatelessWidget {
  final List<Disease> diseases = diseaseList;

  const Diseases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
