import 'package:flower_info/models/flower_model.dart';
import 'package:flower_info/models/flower_model_with_id.dart';
import 'package:flower_info/models/flower_single_view_arguments.dart';
import 'package:flower_info/screens/flowers/flower_singleview.dart';
import 'package:flutter/material.dart';

class FlowerItemTile extends StatelessWidget {
  const FlowerItemTile({Key? key, required this.flowerWithId})
      : super(key: key);

  final FlowerWithId flowerWithId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          FlowerSingleView.routeName,
          arguments: FlowerSingleViewArguments(flowerWithId),
        );
      },
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridTile(
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
      ),
    );
  }
}
