import 'package:flower_info/api/firebase_api.dart';
import 'package:flower_info/components/flowers/flower_item_tile.dart';
import 'package:flower_info/data/flower_data.dart';
import 'package:flutter/material.dart';

import '../../models/flower_model.dart';
import '../../models/flower_model_with_id.dart';

class FLowers extends StatelessWidget {
  const FLowers({Key? key}) : super(key: key);

  final List<Flower> flowers = flowerList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: FirebaseApi.flowersWithId,
        builder: (BuildContext context,AsyncSnapshot<List<FlowerWithId>> snapshot){
          if(snapshot.hasError){
            return const Center(child: Text('Oops.. Something went wrong', style: TextStyle(fontSize: 30),),);
          }
          if(snapshot.hasData){
            return GridView.builder(
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context,int index) {
                return FlowerItemTile(flowerWithId : snapshot.data![index]);
              },
            );
          }
          else{
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            );
          }
        },

      ),
    );
  }
}
