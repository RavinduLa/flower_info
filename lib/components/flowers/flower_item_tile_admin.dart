import 'package:flower_info/api/firebase_api.dart';
import 'package:flower_info/models/flower_admin_single_view_arguments.dart';
import 'package:flower_info/models/flower_model_with_id.dart';
import 'package:flower_info/models/flower_single_view_arguments.dart';
import 'package:flower_info/screens/flowers/edit_flower.dart';
import 'package:flower_info/screens/flowers/flower_singleview.dart';
import 'package:flutter/material.dart';

/*
* IT19014128 - A.M.W.W.R.L. Wataketiya
*
* */

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
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            FlowerSingleView.routeName,
            arguments: FlowerSingleViewArguments(flower),
          );
        },
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            minLeadingWidth: 100,
            title: Text(flower.commonName),
            subtitle: Text(
              flower.scientificName,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
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
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
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
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.amber),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Future<void> result =
                                      deleteFlower(flower.documentId);
                                  Navigator.of(context).pop();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Flower Deleted'),
                                    ),
                                  );
                                },
                                child: const Text('Yes'),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.redAccent),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> deleteFlower(String id) {
    FirebaseApi.deleteFlowerImage(id);
    return FirebaseApi.deleteFlower(id);
  }
}
