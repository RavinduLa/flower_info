import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_info/api/disease_api.dart';
import 'package:flower_info/models/diseases/disease_model_id.dart';
import 'package:flower_info/models/diseases/disease_single_view.dart';
import 'package:flower_info/screens/diseases/disease_edit.dart';
import 'package:flower_info/screens/diseases/disease_view.dart';

class DiseaseItemTileAdmin extends StatelessWidget {
  final DiseaseWithId disease;

  const DiseaseItemTileAdmin({Key? key, required this.disease})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String diseaseName = disease.name;

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
                  imageUrl: disease.image,
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
                            diseaseName,
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
                                  DiseaseEdit.routeName,
                                  arguments: DiseaseSingleView(disease),
                                );
                              },
                              icon: const Icon(Icons.edit,
                                  size: 30, color: Colors.blueGrey),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_forever,
                                  size: 30, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Delete This Disease?'),
                                      content: Text(
                                          'This will delete the $diseaseName permanently!'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.amber),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Future<void> result =
                                                _deleteDisease(disease);
                                            Navigator.of(context).pop();
                                            _notification("Disease Deleted!");
                                          },
                                          child: const Text('Yes'),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.redAccent),
                                          ),
                                        ),
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
          DiseaseView.routeName,
          arguments: DiseaseSingleView(disease),
        );
      },
    );
  }

  // CRUD : Delete Method Caller
  Future<void> _deleteDisease(DiseaseWithId disease) async {
    DiseaseApi.deleteDisease(disease);
  }
}
