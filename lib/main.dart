import 'package:firebase_core/firebase_core.dart';
import 'package:flower_info/providers/application_state.dart';
import 'package:flower_info/providers/theme_provider.dart';
import 'package:flower_info/screens/admin/admin_dashboard.dart';
import 'package:flower_info/screens/admin/admin_dashboard_checked.dart';
import 'package:flower_info/screens/admin/admin_login.dart';
import 'package:flower_info/screens/fertilizers/fertilizer_add.dart';
import 'package:flower_info/screens/fertilizers/fertilizer_admin_list.dart';
import 'package:flower_info/screens/fertilizers/fertilizer_edit.dart';
import 'package:flower_info/screens/fertilizers/fertilizer_view.dart';
import 'package:flower_info/screens/diseases/disease_add.dart';
import 'package:flower_info/screens/diseases/disease_admin.dart';
import 'package:flower_info/screens/diseases/disease_edit.dart';
import 'package:flower_info/screens/diseases/disease_view.dart';
import 'package:flower_info/screens/flowers/add_flower.dart';
import 'package:flower_info/screens/flowers/edit_flower.dart';
import 'package:flower_info/screens/flowers/flower_admin_list.dart';
import 'package:flower_info/screens/flowers/flower_singleview.dart';
import 'package:flower_info/screens/flowers/flower_tests.dart';
import 'package:flower_info/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
*
*
* IT19014128 - A.M.W.W.R.L. Wataketiya
* IT19180526 - S.A.N.L.D. Chandrasiri
* IT19240848 - H.G. Malwatta
*
*
*
* Note : No code was copied in this project
* Where references are added, no code was directly copied from the reference.
* Instead the reference was used to get the idea about the task and implementation was done
* in our own way by us.
* This is our own work
*
* Firebase implementation - https://youtu.be/wUSkeTaBonA
*
* */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //use multiple providers ???
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);

        return ChangeNotifierProvider(
          create: (context) => ApplicationState(),
          builder: (context, _) {
            final appState = Provider.of<ApplicationState>(context);
            return MaterialApp(
              title: 'Flower Info',
              debugShowCheckedModeBanner: false,
              theme: CustomTheme.lightTheme,
              darkTheme: CustomTheme.darkTheme,
              themeMode: themeProvider.themeMode,
              initialRoute: Home.routeName,
              routes: {
                Home.routeName: (context) => Home(),
                AdminDashboard.routeName: (context) => AdminDashboard(),
                FlowerAdminList.routeName: (context) => FlowerAdminList(),
                AddFlower.routeName: (context) => AddFlower(),
                FlowerTest.routeName : (context) => FlowerTest(),
                EditFlower.routeName : (context) => EditFlower(),
                FlowerSingleView.routeName : (context) => FlowerSingleView(),
                DiseaseAdmin.routeName: (context) => DiseaseAdmin(),
                DiseaseAdd.routeName: (context) => DiseaseAdd(),
                DiseaseEdit.routeName: (context) => DiseaseEdit(),
                DiseaseView.routeName: (context) => DiseaseView(),
                FertilizerAdd.routeName: (context) => FertilizerAdd(),
                FertilizerView.routeName: (context) => FertilizerView(),
                FertilizerEdit.routeName: (context) => FertilizerEdit(),
                FertilizerAdmin.routeName: (context) => FertilizerAdmin(),
                AdminLogin.routeName:(context) => AdminLogin(),
                AdminDashboardChecked.routeName: (context) => AdminDashboardChecked()
              },
            );
          },
        );
      },
    );
  }
}
