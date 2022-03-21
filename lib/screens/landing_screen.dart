import 'package:flower_info/components/theme_alert.dart';
import 'package:flower_info/screens/admin/admin_dashboard.dart';
import 'package:flower_info/screens/admin/admin_login.dart';
import 'package:flower_info/screens/diseases/diseases.dart';
import 'package:flower_info/screens/fertilizers/fertilizers.dart';
import 'package:flower_info/screens/flowers/flowers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/theme_provider.dart';

String finalEmail = '';
bool isUserLogged = false;

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int currentIndex = 0;
  final screens = [const FLowers(), const Fertilizers(), const Diseases()];
  late PageController _pageController;

  @override
  void initState() {
    getUserValidationData().whenComplete(() async {
      if (finalEmail.isNotEmpty) {
        isUserLogged = true;
      }
    });
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

// <<<<<<< hirush_adminLogin
//   Future getUserValidationData() async {
//     final SharedPreferences sharedPreferences =
//     await SharedPreferences.getInstance();
//     var obtainedEmail = sharedPreferences.getString('email');

//     setState(() {
//       finalEmail = obtainedEmail!;
// =======
//   void _onItemTapped(int index) {
//     setState(() {
//       currentIndex = index;
// >>>>>>> master
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Flower Info"),
        actions: const [],
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
        child: ListView(
          children: [
            const DrawerHeader(
              child: Icon(
                Icons.settings,
                size: 50,
              ),
// <<<<<<< hirush_adminLogin
//                isUserLogged ?
//                ListTile(
//                 title: Text("Admin"),
//                 subtitle: Text("Admin Dashboard"),
//                 onTap: () {
//                   Navigator.of(context).pushNamed(AdminDashboard.routeName);
//                 },
//               )
//               :
//               ListTile(
//                 title: Text("Admin"),
//                 subtitle: Text("Admin Login"),
//                 onTap: () {
//                   Navigator.of(context).pushNamed(AdminLogin.routeName);
//                 },
//               )
//             ],
//           ),
//         ),
//         body: SizedBox.expand(
//           child: PageView(
//             controller: _pageController,
//             onPageChanged: (index) {
//               setState(() => currentIndex = index);
//             },
//             children: screens,
//           ),
//         ),
//         bottomNavigationBar: Container(
//           padding: const EdgeInsets.all(30.0),
//           child: Container(
//             //padding: EdgeInsets.all(30.0),
//             height: 60,
//             decoration: BoxDecoration(
//               color: Theme.of(context).primaryColor,
//               borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(50),
//                   bottomLeft: Radius.circular(50),
//                   bottomRight: Radius.circular(20)),
// =======
// >>>>>>> master
//             ),
            ListTile(
              title: const Text("Theme"),
              subtitle: Text(themeProvider.selectedTheme),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => const ThemeAlert(),
                    barrierDismissible: true);
              },
            ),
            ListTile(
              title: const Text("Admin"),
              subtitle: const Text("Admin Dashboard"),
              onTap: () {
                Navigator.of(context).pushNamed(AdminDashboard.routeName);
              },
            )
          ],
        ),
      ),
      body: SizedBox.expand(
        child: Center(
          child: screens.elementAt(currentIndex),
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop),
            label: 'Fertilizers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.coronavirus),
            label: 'Diseases',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).primaryColor,
        iconSize: 40,
        selectedFontSize: 15,
        unselectedFontSize: 10,
        onTap: _onItemTapped,
      ),
    );
  }
}
