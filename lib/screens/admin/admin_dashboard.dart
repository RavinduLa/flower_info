import 'package:flower_info/screens/diseases/disease_admin.dart';
import 'package:flower_info/screens/flowers/flower_tests.dart';
import 'package:flutter/material.dart';

import '../flowers/flower_admin_list.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  static String routeName = "/admin-dashboard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: const Card(
                  color: Colors.purple,
                  child: SizedBox(
                    height: 100,
                    child: Center(
                      child: Text("Flower Panel", style: TextStyle(fontSize: 30),),
                    ),
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, FlowerAdminList.routeName),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: const Card(
                  color: Colors.green,
                  child: SizedBox(
                    height: 100,
                    child: Center(
                      child: Text("Fertilizers Panel", style: TextStyle(fontSize: 30),),
                    ),
                  ),
                ),
                //onTap: () => Navigator.pushNamed(context, FlowerAdminList.routeName),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: const Card(
                  color: Colors.amber,
                  child: SizedBox(
                    height: 100,
                    child: Center(
                      child: Text("Diseases Panel", style: TextStyle(fontSize: 30),),
                    ),
                  ),
                ),
                onTap: () => Navigator.pushNamed(context,DiseaseAdmin.routeName),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, FlowerAdminList.routeName);
              },
              child: Text(
                'Flower Panel',
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Fertilizers Panel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, DiseaseAdmin.routeName);
              },
              child: Text('Diesases Panel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, FlowerTest.routeName);
              },
              child: Text('Flower Tests'),
            ),
          ],
        ),
      ),
    );
  }
}
