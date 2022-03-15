import 'package:flutter/material.dart';

import 'disease_add.dart';

class DiseaseAdmin extends StatelessWidget {
  const DiseaseAdmin({Key? key}) : super(key: key);

  static String routeName = "/admin/disease/disease-list";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diseases Admin Panel'),
      ),
      body: const Center(
        child: Text('Diseases Admin list'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, DiseaseAdd.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
