/*
* @author IT19240848 - H.G. Malwatta
*
* Note : No code was copied in this project
* Where references are added, no code was directly copied from the reference.
* Instead the reference was used to get the idea about the task
* and implementation was done in our own way by us.
* This is our own work.
*
* Firebase Firestore
* https://firebase.flutter.dev/docs/firestore/usage
* https://youtu.be/wUSkeTaBonA
*
* Read Data From Firestore
* https://youtu.be/G4INTsatBew
*
* */

import 'package:flower_info/api/fertilizer_api.dart';
import 'package:flower_info/components/Fertilizers/fertilizer_item_tile_admin.dart';
import 'package:flower_info/components/constants.dart';
import 'package:flower_info/models/fertilizer_model_id.dart';
import 'package:flower_info/screens/fertilizers/fertilizer_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FertilizerAdmin extends StatelessWidget {
  const FertilizerAdmin({Key? key}) : super(key: key);

  static String routeName = Constants.routNameFertilizerList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Fertilizer Admin Panel'),
      ),
      body: StreamBuilder(
        stream: FertilizerApi.readFertilizerWithId(),
        builder: (BuildContext context,
            AsyncSnapshot<List<FertilizerWithId>> snapshot) {
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
              return FertilizerItemTileAdmin(fertilizer: snapshot.data![index]);
            },
            itemCount: snapshot.data!.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, FertilizerAdd.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
