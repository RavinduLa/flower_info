import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../api/disease_api.dart';

class DiseaseView extends StatelessWidget {
  static String routeName = "/admin/disease/disease-view";

  const DiseaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as DiseaseSingleView;

    if (kDebugMode) {
      print(data.disease.documentId);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(data.disease.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.network(data.disease.image),
            ),
            Text(
              data.disease.name,
              style: const TextStyle(fontSize: 35),
            ),
            const SizedBox(height: 20),
            informationSection("What Does it Look Like?", data.disease.look),
            informationSection("What Causes it?", data.disease.cause),
            informationSection("How to Treat it?", data.disease.treat),
            informationSection("How to Prevent it?", data.disease.prevent),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  informationSection(String title, String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 22),
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
