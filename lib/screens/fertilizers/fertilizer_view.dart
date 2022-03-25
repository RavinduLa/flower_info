/*
* @author IT19240848 - H.G. Malwatta
*
* Note : No code was copied in this project
* Where references are added, no code was directly copied from the reference.
* Instead the reference was used to get the idea about the task
* and implementation was done in our own way by us.
* This is our own work.
*
* Firebase Firestore
* https://firebase.flutter.dev/docs/firestore/usage
* https://youtu.be/wUSkeTaBonA
*
*
* */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_info/api/fertilizer_api.dart';
import 'package:flower_info/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FertilizerView extends StatefulWidget {

  static String routeName = Constants.routNameFertilizerView;
  const FertilizerView({Key? key}) : super(key: key);

  @override
  State<FertilizerView> createState() => _FertilizerViewState();
}

class _FertilizerViewState extends State<FertilizerView> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    //Fetching data from Firestore
    final data =
    ModalRoute.of(context)!.settings.arguments as FertilizerSingleView;

    if (kDebugMode) {
      print(data.fertilizer.documentId);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(data.fertilizer.brandName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(width: double.infinity),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: CachedNetworkImage(
                imageUrl: data.fertilizer.image,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                const Icon(Icons.error, size: 50),
                placeholder: (context, url) => const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                data.fertilizer.brandName,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  informationSection(
                    Constants.fertilizerLabelType,
                    data.fertilizer.type,
                  ),
                  informationSection(
                    Constants.fertilizerLabelNitrogenValue,
                    data.fertilizer.nitrogienValue,
                  ),
                  informationSection(
                    Constants.fertilizerLabelPhosphorusValue,
                    data.fertilizer.phosporosValue,
                  ),
                  informationSection(
                    Constants.fertilizerLabelPotassiumValue,
                    data.fertilizer.potasiamValue,
                  ),
                  informationSection(
                    Constants.fertilizerLabelDescription,
                    data.fertilizer.description,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Implement Method to show fertilizer in detail
  informationSection(String title, String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, ),
            ),
            const SizedBox(height: 6),
            Text(
              text,
              style: const TextStyle(fontSize: 15,fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}