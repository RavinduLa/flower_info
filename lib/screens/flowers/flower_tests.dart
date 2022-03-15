import 'package:flower_info/api/firebase_api.dart';
import 'package:flutter/material.dart';

class FlowerTest extends StatefulWidget {
  const FlowerTest({Key? key}) : super(key: key);
  static String routeName = "/admin/flowers/flower-tests";
  @override
  _FlowerTestState createState() => _FlowerTestState();
}

class _FlowerTestState extends State<FlowerTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flower Tests'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                FirebaseApi.testEditFlower("asd");
              },
              child: Text('Test Editing'),
            ),

            ElevatedButton(
              onPressed: () {
                FirebaseApi.getFlowersTest();
              },
              child: Text('Get flower uid'),
            ),
          ],
        ),
      ),
    );
  }
}
