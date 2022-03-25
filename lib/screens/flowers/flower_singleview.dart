import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_info/components/flowers/flower_singleview_info_container.dart';
import 'package:flower_info/models/flower_single_view_arguments.dart';
import 'package:flutter/material.dart';

/*
* IT19014128 (A.M.W.W.R.L. Wataketiya)
*
* Note : No code was copied in this project
* Where references are added, no code was directly copied from the reference.
* Instead the reference was used to get the idea about the task and implementation was done
* in our own way by us.
* This is our own work
*
*
* Firebase - https://youtu.be/wUSkeTaBonA
* Cached network image - https://pub.dev/packages/cached_network_image
*
* */

class FlowerSingleView extends StatelessWidget {
  const FlowerSingleView({Key? key}) : super(key: key);

  static String routeName = "/admin/flowers/flower-single-view";
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as FlowerSingleViewArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.flowerWithId.commonName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: args.flowerWithId.imageLink,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            FlowerInfoContainer(
              title: "Common Name",
              subtitle: args.flowerWithId.commonName,
              fontStyle: FontStyle.normal,
            ),
            FlowerInfoContainer(
              title: "Scientific Name",
              subtitle: args.flowerWithId.scientificName,
              fontStyle: FontStyle.italic,
            ),
            FlowerInfoContainer(
              title: "Mature Size",
              subtitle: args.flowerWithId.matureSize,
              fontStyle: FontStyle.normal,
            ),
            FlowerInfoContainer(
              title: "Native Region",
              subtitle: args.flowerWithId.nativeRegion,
              fontStyle: FontStyle.normal,
            ),
          ],
        ),
      ),
    );
  }
}
