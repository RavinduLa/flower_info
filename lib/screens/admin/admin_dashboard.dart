import 'package:flutter/material.dart';import 'package:shared_preferences/shared_preferences.dart';

import '../flowers/flower_admin_list.dart';
import '../home.dart';

String finalEmail = '';
bool isUserLogged = false;

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  static String routeName = "/admin-dashboard";

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  void initState() {
    // TODO: implement initState
    getUserValidationData().whenComplete(() async {
      if (finalEmail.isNotEmpty) {
        isUserLogged = true;
      }
    });
    super.initState();
  }

  Future getUserValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');

    setState(() {
      finalEmail = obtainedEmail!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: size.height * 0.05),
            Center(
                child: Text('Hello $finalEmail', style: const TextStyle(fontSize: 20, color: Colors.green),),
            ),
            SizedBox(height: size.height * 0.1),
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
              onPressed: () {},
              child: Text('Diesases Panel Panel'),
            ),
            SizedBox(height: size.height * 0.3),
            ElevatedButton(
              onPressed: () async {
                final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.remove('email');

                isUserLogged = false;

                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => Home(),
                  ),
                );
              },
              child: const Text(
                'Log out',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow
              ),
            ),
          ],
        ),
      ),
    );
  }
}
