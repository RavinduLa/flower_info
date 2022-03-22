import 'package:flutter/material.dart';
import 'package:flower_info/components/constants.dart';
import 'package:flower_info/components/diseases/disease_information_section.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_info/models/diseases/disease_single_view.dart';

class DiseaseView extends StatelessWidget {
  static String routeName = Constants.routeNameDiseaseView;

  const DiseaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as DiseaseSingleView;

    String _name = data.disease.name;
    String _image = data.disease.image;
    String _look = data.disease.look;
    String _cause = data.disease.cause;
    String _treat = data.disease.treat;
    String _prevent = data.disease.prevent;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(width: double.infinity),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: CachedNetworkImage(
                imageUrl: _image,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
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
                _name,
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
                    title: Constants.diseaseLabelLook,
                    information: _look,
                  ),
                  DiseaseInformationSection(
                    title: Constants.diseaseLabelCause,
                    information: _cause,
                  ),
                  DiseaseInformationSection(
                    title: Constants.diseaseLabelTreat,
                    information: _treat,
                  ),
                  DiseaseInformationSection(
                    title: Constants.diseaseLabelPrevent,
                    information: _prevent,
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
