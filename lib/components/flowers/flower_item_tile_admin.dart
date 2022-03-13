import 'package:flower_info/api/firebase_api.dart';
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
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, EditFlower.routeName,
                      arguments: FlowerAdminSingleViewArguments(
                          flower) //navigate to pizza
                      );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  print("Delete pressed");
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Remove this flower?'),
                          content: const Text('This action cannot be undone'),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No')),
                            ElevatedButton(
                                onPressed: () {
                                  Future<void> result =
                                      deleteFlower(flower.documentId);
                                  Navigator.of(context).pop();

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text('Flower Deleted'),
                                    ),
                                  );

                                },
                                child: const Text('Yes'))
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, EditFlower.routeName,
                arguments:
                    FlowerAdminSingleViewArguments(flower) //navigate to pizza
                );
          },
        ),
      ),
    );
  }

  Future<void> deleteFlower(String id) {
    FirebaseApi.deleteFlowerImage(id);
    return FirebaseApi.deleteFlower(id);
  }
}
