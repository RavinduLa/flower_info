/*
* IT19240848 - H.G. Malwatta
* My Contribution - (Admin Logout Button and User name Display)
*
* Shared Preferences
* https://pub.dev/packages/shared_preferences/example
* https://youtu.be/56_PDVvPKOc
*
* */

import 'package:flower_info/screens/admin/admin_login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flower_info/screens/fertilizers/fertilizer_admin_list.dart';
import 'package:flower_info/screens/diseases/disease_admin.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../providers/theme_provider.dart';
import '../flowers/flower_admin_list.dart';
import '../home.dart';
import 'admin_dashboard_checked.dart';

/*
* IT19014128 - A.M.W.W.R.L. Wataketiya
*
* */


String finalEmail = '';

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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Admin Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              heightFactor: 3,
              child: Text(
                "Hello $finalEmail",
                style: const TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 75, right: 75),
              child: ElevatedButton(
                  onPressed: () async {
                    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.remove('email');

                    isUserLogged = false;

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Home(),
                      ),
                          (route) => false,
                    );
                  },
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.yellow)
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: ()=>Navigator.pushNamed(context, FlowerAdminList.routeName),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => Navigator.pushNamed(context, FertilizerAdmin.routeName),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => Navigator.pushNamed(context, DiseaseAdmin.routeName),
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
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
