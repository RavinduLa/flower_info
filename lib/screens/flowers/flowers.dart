import 'package:flower_info/components/flowers/flower_item_tile.dart';
import 'package:flower_info/data/flower_data.dart';
import 'package:flutter/material.dart';

import '../../models/flower_model.dart';

class FLowers extends StatelessWidget {
  const FLowers({Key? key}) : super(key: key);

  final List<Flower> flowers = flowerList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemCount: flowers.length,
        itemBuilder: (context, index) {
          return FlowerItemTile(flower: flowers[index]);
        },
      ),
    );
  }
}
