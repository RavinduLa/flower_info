import 'package:flutter/material.dart';

class FlowerAdminList extends StatelessWidget {
  const FlowerAdminList({Key? key}) : super(key: key);
  static String routeName = "/admin/flowers/flower-list";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flowers Admin Panel'),
      ),
      body: Center(
        child: Text('Flower Admin list'),
      ),
    );
  }
}
