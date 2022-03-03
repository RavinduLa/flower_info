import 'package:flutter/material.dart';

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
            onPressed: () {},
            child: Text(
              'Flower Panel',
            ),

          ),
          ElevatedButton(
            onPressed: () {},
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
