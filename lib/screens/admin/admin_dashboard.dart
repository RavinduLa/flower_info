import 'package:flower_info/screens/fertilizers/fertilizer_add.dart';
import 'package:flower_info/screens/fertilizers/fertilizer_admin_list.dart';
import 'package:flower_info/screens/fertilizers/fertilizer_view.dart';
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
            onPressed: () {
              Navigator.pushNamed(context, FertilizerAdmin.routeName);
            },
            child: Text('Fertilizers Panel'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Diesases Panel Panel'),
          ),
        ],
      ),
    );
  }
}
