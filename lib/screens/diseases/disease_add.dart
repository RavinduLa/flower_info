import 'package:flutter/material.dart';

class DiseaseAdd extends StatefulWidget {
  const DiseaseAdd({Key? key}) : super(key: key);

  static String routeName = "/admin/disease/disease-add";

  @override
  State<DiseaseAdd> createState() => _DiseaseAddState();
}

class _DiseaseAddState extends State<DiseaseAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diseases Create'),
      ),
      body: const Center(
        child: Text('Diseases Create'),
      ),
    );
  }
}
