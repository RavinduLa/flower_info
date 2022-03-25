/*
*   @author IT19240848 - H.G. Malwatta
*/

import 'package:flower_info/api/fertilizer_api.dart';
import 'package:flower_info/components/Fertilizers/fertilizer_item_tile.dart';
import 'package:flower_info/models/fertilizer_model_id.dart';
import 'package:flutter/material.dart';

class Fertilizers extends StatelessWidget {
  const Fertilizers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
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

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return FertilizerItemTile(fertilizer: snapshot.data![index]);
            },
          );
        },
      ),
    );
  }
}
