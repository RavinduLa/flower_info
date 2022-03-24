import 'package:flower_info/api/firebase_api.dart';
import 'package:flower_info/components/flowers/flower_item_tile_admin.dart';
import 'package:flower_info/models/flower_model_with_id.dart';

import 'package:flower_info/screens/flowers/add_flower.dart';
import 'package:flutter/material.dart';

/*
* IT19014128 (A.M.W.W.R.L. Wataketiya)
*
* Note : No code was copied in this project
* Where references are added, no code was directly copied from the reference.
* Instead the reference was used to get the idea about the task and implementation was done
* in our own way by us.
* This is our own work
*
*
* Firebase - https://youtu.be/wUSkeTaBonA
*
* */


class FlowerAdminList extends StatelessWidget {
  const FlowerAdminList({Key? key}) : super(key: key);

  static String routeName = "/admin/flowers/flower-list";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flowers Admin Panel'),
      ),
      body: StreamBuilder(
        stream: FirebaseApi.flowersWithId,
        builder: (BuildContext context, AsyncSnapshot<List<FlowerWithId>> snapshot) {
          if(snapshot.hasError){
            return const Center(child: Text('Oops Something went wrong'),);
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: FlowerItemTileAdmin(flower: snapshot.data![index]),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddFlower.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
