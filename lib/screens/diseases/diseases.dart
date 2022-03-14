import 'package:flutter/material.dart';

import '../../api/disease_api.dart';
import '../../components/diseases/disease_item_tile.dart';
import '../../data/disease_data.dart';
import '../../models/disease_model.dart';
import '../../models/disease_model_id.dart';

class Diseases extends StatelessWidget {
  final List<Disease> diseases = diseaseList;

  const Diseases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: DiseaseApi.readDiseaseWithId(),
        builder: (BuildContext context,
            AsyncSnapshot<List<DiseaseWithId>> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading"),
            );
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return DiseaseItemTile(disease: snapshot.data![index]);
            },
          );
        },
      ),
    );
  }
}
