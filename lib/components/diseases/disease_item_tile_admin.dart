import 'package:flower_info/api/disease_api.dart';
import 'package:flower_info/models/disease_model.dart';
import 'package:flower_info/models/disease_model_id.dart';
import 'package:flower_info/screens/diseases/disease_edit.dart';
import 'package:flutter/material.dart';

class DiseaseItemTileAdmin extends StatelessWidget {
  final DiseaseWithId disease;

  const DiseaseItemTileAdmin({Key? key, required this.disease})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(10),
      child: Container(
        height: 100,
        child: Row(
          children: [
            Center(
              child: Image.network(disease.image),
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
                          disease.name,
                          style: const TextStyle(
                            fontSize: 24,
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
                            icon: const Icon(Icons.edit),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete_forever),
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
    );
  }
}
