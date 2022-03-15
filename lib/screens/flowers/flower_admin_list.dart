import 'package:flower_info/api/firebase_api.dart';
import 'package:flower_info/components/flowers/flower_item_tile_admin.dart';
import 'package:flower_info/models/flower_model_with_id.dart';

import 'package:flower_info/screens/flowers/add_flower.dart';
import 'package:flutter/material.dart';


class FlowerAdminList extends StatelessWidget {
  const FlowerAdminList({Key? key}) : super(key: key);

  static String routeName = "/admin/flowers/flower-list";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flowers Admin Panel'),
      ),
      body: StreamBuilder(
        stream: FirebaseApi.flowersWithId,
        builder: (BuildContext context, AsyncSnapshot<List<FlowerWithId>> snapshot) {
          if(snapshot.hasError){
            return Center(child: Text('Oops Something went wrong'),);
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return FlowerItemTileAdmin(flower: snapshot.data![index]);
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
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
