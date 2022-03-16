import 'package:flower_info/screens/diseases/disease_view.dart';
import 'package:flutter/material.dart';
import 'package:flower_info/models/disease_model_id.dart';

import '../../api/disease_api.dart';

class DiseaseItemTile extends StatelessWidget {
  final DiseaseWithId disease;

  const DiseaseItemTile({Key? key, required this.disease}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
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
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          DiseaseView.routeName,
          arguments: DiseaseSingleView(disease),
        );
      },
    );
  }
}
