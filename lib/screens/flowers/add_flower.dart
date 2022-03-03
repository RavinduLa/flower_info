import 'package:flutter/material.dart';

class AddFlower extends StatefulWidget {
  const AddFlower({Key? key}) : super(key: key);
  static String routeName = "/admin/flowers/add-flower";

  @override
  _AddFlowerState createState() => _AddFlowerState();
}

class _AddFlowerState extends State<AddFlower> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a flower'),
      ),
      body: Column(
        children: [Text('Add a flower')],
      ),
    );
  }
}
