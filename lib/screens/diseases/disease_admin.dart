import 'package:flower_info/api/disease_api.dart';
import 'package:flower_info/components/diseases/disease_item_tile_admin.dart';
import 'package:flower_info/models/disease_model_id.dart';
import 'package:flutter/material.dart';

import 'disease_add.dart';

class DiseaseAdmin extends StatelessWidget {
  const DiseaseAdmin({Key? key}) : super(key: key);

  static String routeName = "/admin/disease/disease-list";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diseases Admin Panel'),
      ),
      body: StreamBuilder(
        stream: DiseaseApi.readDiseaseWithId(),
        builder: (BuildContext context, AsyncSnapshot<List<DiseaseWithId>> snapshot) {
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
