import 'package:flower_info/screens/diseases/disease_admin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../flowers/flower_admin_list.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  static String routeName = "/admin-dashboard";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeMode = themeProvider.themeMode;
    const lightTheme = ThemeMode.light;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              heightFactor: 10,
              child: Text(
                "Hello Admin",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Card(
                  color: themeMode == lightTheme
                      ? Colors.purple.shade300
                      : Colors.deepPurple,
                  child: const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        "Flower Panel",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                onTap: () =>
                    Navigator.pushNamed(context, FlowerAdminList.routeName),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Card(
                  color: themeMode == lightTheme
                      ? Colors.green.shade300
                      : Colors.green.shade800,
                  child: const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        "Fertilizers Panel",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                //onTap: () => Navigator.pushNamed(context, FlowerAdminList.routeName),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Card(
                  color: themeMode == lightTheme
                      ? Colors.brown.shade300
                      : Colors.brown.shade700,
                  child: const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        "Diseases Panel",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                onTap: () =>
                    Navigator.pushNamed(context, DiseaseAdmin.routeName),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
