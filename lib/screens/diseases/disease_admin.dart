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
import 'package:flower_info/components/diseases/disease_item_tile_admin.dart';
import 'package:flower_info/models/diseases/disease_model_id.dart';
import 'package:flower_info/screens/diseases/disease_add.dart';


class DiseaseAdmin extends StatelessWidget {
  const DiseaseAdmin({Key? key}) : super(key: key);

  static String routeName = Constants.routeNameDiseaseList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(Constants.diseaseAdminPanel),
      ),
      body: StreamBuilder(
        stream: DiseaseApi.readDiseaseWithId(),
        builder: (BuildContext context, AsyncSnapshot<List<DiseaseWithId>> snapshot) {
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

          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return DiseaseItemTileAdmin(disease: snapshot.data![index]);
            },
            itemCount: snapshot.data!.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, DiseaseAdd.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
