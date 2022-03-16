import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_info/screens/diseases/disease_view.dart';
import 'package:flutter/material.dart';
import 'package:flower_info/models/disease_model_id.dart';

import '../../api/disease_api.dart';

class DiseaseItemTile extends StatelessWidget {
  final DiseaseWithId disease;

  const DiseaseItemTile({Key? key, required this.disease}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
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
                    child: CachedNetworkImage(
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      imageUrl: disease.image,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, size: 50),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ),
                  ),
                ),
                Text(disease.name),
              ],
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
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
}
