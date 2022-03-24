/*
* IT19180526 (S.A.N.L.D. Chandrasiri)
*
* Note : No code was copied in this project
* Where references are added, no code was directly copied from the reference.
* Instead the reference was used to get the idea about the task
* and implementation was done in our own way by us.
* This is our own work.
*
* Firebase firestore
* https://firebase.flutter.dev/docs/firestore/usage
* https://youtu.be/wUSkeTaBonA
* https://youtu.be/G4INTsatBew
*
* */

import 'package:flower_info/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flower_info/api/disease_api.dart';
import 'package:flower_info/components/diseases/disease_item_tile.dart';
import 'package:flower_info/data/disease_data.dart';
import 'package:flower_info/models/diseases/disease_model.dart';
import 'package:flower_info/models/diseases/disease_model_id.dart';

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
              child: Text(Constants.somethingWentWrong),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
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
