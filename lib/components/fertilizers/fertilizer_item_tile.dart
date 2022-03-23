import 'package:flower_info/api/fertilizer_api.dart';
import 'package:flower_info/screens/fertilizers/fertilizer_view.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../models/fertilizer_model_id.dart';

class FertilizerItemTile extends StatelessWidget {
  final FertilizerWithId fertilizer;

  const FertilizerItemTile({Key? key, required this.fertilizer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 2,
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(
              context,
              FertilizerView.routeName,
              arguments: FertilizerSingleView(fertilizer),
            );
          },
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
                        imageUrl: fertilizer.image,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error, size: 50),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                    ),
                  ),
                  Text(fertilizer.brandName),
                ],
              ),
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
