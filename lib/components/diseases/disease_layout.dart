import 'package:flutter/material.dart';

class DiseaseLayout extends StatelessWidget {
  final String title;
  final Widget? body;
  final Widget? floatingActionButton;

  const DiseaseLayout(
      {Key? key, required this.title, this.body, this.floatingActionButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
