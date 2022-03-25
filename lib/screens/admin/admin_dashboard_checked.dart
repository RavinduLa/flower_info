/*
* @author IT19240848 - H.G. Malwatta
 */

import 'package:flower_info/screens/admin/admin_dashboard.dart';
import 'package:flower_info/screens/admin/admin_login.dart';
import 'package:flutter/material.dart';

import '../../components/constants.dart';


bool isUserLogged = false;
class AdminDashboardChecked extends StatefulWidget {
  const AdminDashboardChecked({Key? key}) : super(key: key);

  static String routeName =  Constants.routeNameAdminDashboardChecked;

  @override
  State<AdminDashboardChecked> createState() => _AdminDashboardCheckedState();
}

class _AdminDashboardCheckedState extends State<AdminDashboardChecked> {

  @override
  Widget build(BuildContext context) {
    if (isUserLogged){
      return const AdminDashboard();
    }else{
      return const AdminLogin();
    }
  }
}
