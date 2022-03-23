import 'package:flower_info/components/constants.dart';
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
    String _name = disease.name;
    String _image = disease.image;
    String _look = disease.look;
    String _cause = disease.cause;
    String _treat = disease.treat;
    String _prevent = disease.prevent;

    // Common Notification
    void _notification(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }

    return Card(
      child: InkWell(
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: _image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, size: 25),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ),
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
                            _name,
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
                                  size: 30, color: Colors.green),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  size: 30, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                          Constants.diseaseDeleteAsk),
                                      content: Text(
                                          Constants.deletePermanently + _name),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            Constants.cancel,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
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
                                            _notification(
                                                Constants.diseaseDeleted);
                                          },
                                          child: const Text(Constants.yes),
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
        onTap: () {
          Navigator.pushNamed(
            context,
            DiseaseView.routeName,
            arguments: DiseaseSingleView(disease),
          );
        },
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      elevation: 4,
    );
  }

  // CRUD : Delete Method Caller
  Future<void> _deleteDisease(DiseaseWithId disease) async {
    DiseaseApi.deleteDisease(disease);
  }
}
