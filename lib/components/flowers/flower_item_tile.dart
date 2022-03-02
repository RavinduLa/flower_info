import 'package:flower_info/models/flower_model.dart';
import 'package:flutter/material.dart';

class FlowerItemTile extends StatelessWidget {
  const FlowerItemTile({Key? key, required this.flower}) : super(key: key);

  final Flower flower;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 2,
        child: Row(
          children: [
            Expanded(
              child: Image.network(
                flower.imageLink,
              ),
            ),
            Text(flower.commonName)
          ],
        ),
      ),
    );
  }
}
