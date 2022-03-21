import 'package:flower_info/screens/admin/admin_dashboard.dart';
import 'package:flower_info/screens/admin/admin_login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String finalEmail = '';
bool isUserLogged = false;

class AdminDashboardChecked extends StatefulWidget {
  const AdminDashboardChecked({Key? key}) : super(key: key);

  static String routeName = "/admin-dashboard-checked";

  @override
  State<AdminDashboardChecked> createState() => _AdminDashboardCheckedState();
}

class _AdminDashboardCheckedState extends State<AdminDashboardChecked> {

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
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 150),
            isUserLogged ?
              const Padding(
                  padding: EdgeInsets.all(15.0),
                child: Center(
                    child: Text("Welcome!",style: TextStyle(fontSize: 30),)
                ),
                ) :
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                    child: Text("Please Login!",style: TextStyle(fontSize: 30),)
                ),
              ),

            isUserLogged ?
             Padding(
              padding: const EdgeInsets.all(30.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: ()=>Navigator.pushNamed(context, AdminDashboard.routeName),
                  child: const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        "Dashboard",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ) : Padding(
              padding: const EdgeInsets.all(30.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: ()=>Navigator.pushNamed(context, AdminLogin.routeName),
                  child: const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(fontSize: 25, fontWeight:FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]
      ),
    );
  }
}
