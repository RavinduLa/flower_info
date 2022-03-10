import 'package:flower_info/models/flower_admin_single_view_arguments.dart';
import 'package:flower_info/models/flower_model.dart';
import 'package:flower_info/models/flower_model_with_id.dart';
import 'package:flower_info/screens/flowers/edit_flower.dart';
import 'package:flutter/material.dart';

class FlowerItemTileAdmin extends StatelessWidget {
  const FlowerItemTileAdmin({Key? key, required this.flower}) : super(key: key);
  final FlowerWithId flower;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          minLeadingWidth: 100,
          title: Text(flower.commonName),
          subtitle: Text(flower.scientificName + " id : " + flower.documentId),
          onTap: () {
            Navigator.pushNamed(context, EditFlower.routeName,
                arguments: FlowerAdminSingleViewArguments(flower) //navigate to pizza
            );
          },
        ),
      ),
    );
  }
}
