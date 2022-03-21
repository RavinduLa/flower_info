import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_info/api/fertilizer_api.dart';
import 'package:flower_info/models/fertilizer_model_id.dart';
import 'package:flower_info/screens/fertilizers/fertilizer_edit.dart';
import 'package:flower_info/screens/fertilizers/fertilizer_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FertilizerItemTileAdmin extends StatelessWidget {

  final FertilizerWithId fertilizer;
  const FertilizerItemTileAdmin({Key? key, required this.fertilizer}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Common Notification
    void _notification(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
    return GestureDetector(
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.all(10),
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              SizedBox(
                width: 106,
                child: CachedNetworkImage(
                  imageUrl: fertilizer.image,
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error, size: 25),
                  placeholder: (context, url) =>
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: ListTile(
                          title: Text(
                            fertilizer.brandName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  FertilizerEdit.routeName,
                                  arguments: FertilizerSingleView(fertilizer),
                                );
                              },
                              icon: const Icon(Icons.edit),
                              color: Colors.blueAccent,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_forever),
                              color: Colors.redAccent,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Delete This fertilizer?'),
                                      content: const Text(
                                          'This will delete the fertilizer permanently!'),
                                      actions: [
                                        ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Colors.yellow),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel',style: TextStyle(color: Colors.white70),)),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Colors.red),
                                            ),
                                            onPressed: () {
                                              Future<void> result =
                                              _deleteFertilizer(fertilizer);
                                              Navigator.of(context).pop();
                                              _notification("Fertilizer Deleted!");
                                            },
                                            child: const Text('Yes'))
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                flex: 8,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          FertilizerView.routeName,
          arguments: FertilizerSingleView(fertilizer),
        );
      },
    );
  }
  // CRUD : Delete Method Caller
  Future<void> _deleteFertilizer(FertilizerWithId fertilizer) async {
    FertilizerApi.deleteFertilizer(fertilizer);
  }
}