import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_info/models/diseases/disease_single_view.dart';
import 'package:flower_info/screens/diseases/disease_view.dart';
import 'package:flower_info/models/diseases/disease_model_id.dart';

class DiseaseItemTile extends StatelessWidget {
  final DiseaseWithId disease;

  const DiseaseItemTile({Key? key, required this.disease}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _name = disease.name;
    String _image = disease.image;
    String _look = disease.look;
    String _cause = disease.cause;
    String _treat = disease.treat;
    String _prevent = disease.prevent;

    return Card(
      child: InkWell(
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
                    child: CachedNetworkImage(
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      imageUrl: _image,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, size: 50),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ),
                  ),
                ),
                Text(_name),
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
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 2,
    );
  }
}
