import 'package:flower_info/components/constants.dart';
import 'package:flower_info/components/login/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatelessWidget {
  const AdminLogin({Key? key}) : super(key: key);

  static String routeName = Constants.routeNameAdminLogin;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}