import 'package:flower_info/components/diseases/disease_information_section.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_info/models/diseases/disease_single_view.dart';

class DiseaseView extends StatelessWidget {
  static String routeName = "/admin/disease/disease-view";

  const DiseaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as DiseaseSingleView;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(data.disease.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(width: double.infinity),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: CachedNetworkImage(
                imageUrl: data.disease.image,
                width: 200,
                height: 200,
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, size: 50),
                placeholder: (context, url) => const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                data.disease.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 35),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.greenAccent,
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
                  DiseaseInformationSection(
                    title: "What Does it Look Like?",
                    information: data.disease.look,
                  ),
                  DiseaseInformationSection(
                    title: "What Causes it?",
                    information: data.disease.cause,
                  ),
                  DiseaseInformationSection(
                    title: "How to Treat it?",
                    information: data.disease.treat,
                  ),
                  DiseaseInformationSection(
                    title: "How to Prevent it?",
                    information: data.disease.prevent,
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
}
