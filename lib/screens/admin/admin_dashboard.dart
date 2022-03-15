
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
            child: Text('Diesases Panel Panel'),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, FlowerTest.routeName);
            },
            child: Text('Flower Tests'),
          ),
        ],
      ),
    );
  }
}
