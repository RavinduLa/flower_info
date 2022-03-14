import 'package:flower_info/models/flower_model.dart';
import 'package:flower_info/models/flower_model_with_id.dart';
import 'package:flutter/material.dart';

class FlowerItemTile extends StatelessWidget {
  const FlowerItemTile({Key? key, required this.flowerWithId}) : super(key: key);

  final FlowerWithId flowerWithId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    flowerWithId.imageLink,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(flowerWithId.commonName)
            ],
          ),
        ),
      ),
    );
  }
}
