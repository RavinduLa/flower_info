import 'package:flower_info/data/flower_data.dart';
import 'package:flutter/material.dart';

import '../../models/flower_model.dart';

class FLowers extends StatelessWidget {
  const FLowers({Key? key}) : super(key: key);

  final List<Flower> flowers = flowerList;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Flower list'),);
  }
}
