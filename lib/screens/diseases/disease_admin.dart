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
