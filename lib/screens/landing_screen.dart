import 'package:flower_info/components/no_connection_alert.dart';
import 'package:flower_info/components/theme_alert.dart';
import 'package:flower_info/screens/admin/admin_dashboard_checked.dart';
import 'package:flower_info/screens/diseases/diseases.dart';
import 'package:flower_info/screens/fertilizers/fertilizers.dart';
import 'package:flower_info/screens/flowers/flowers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

import '../providers/theme_provider.dart';

/*
*
* IT19014128 (A.M.W.W.R.L. Wataketiya)
*
* Note : No code was copied in this project
* Where references are added, no code was directly copied from the reference.
* Instead the reference was used to get the idea about the task and implementation was done
* in our own way by us.
* This is our own work
*
* Simple connection checker - https://pub.dev/packages/simple_connection_checker
* Flutter cache manager - https://pub.dev/packages/flutter_cache_manager
* Cached network image - https://pub.dev/packages/cached_network_image
*
* */

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int currentIndex = 0;
  final screens = [const FLowers(), const Fertilizers(), const Diseases()];
  late PageController _pageController;
  SimpleConnectionChecker _simpleConnectionChecker = SimpleConnectionChecker();
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _checkConnection();
  }

  _checkConnection() async {
    await _simpleConnectionChecker.onConnectionChange.listen(
      (connected) {
        if (connected) {
          DefaultCacheManager().emptyCache();
        } else {
          _showConnectionAlert(context);
        }
      },
    );
  }

  void _showConnectionAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const NoConnectionAlert(),
      barrierDismissible: true,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
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
            ),
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
                Navigator.of(context)
                    .pushNamed(AdminDashboardChecked.routeName);
              },
            ),
          ],
        ),
      ),
      body: SizedBox.expand(
        child: Center(
          child: screens.elementAt(currentIndex),
        ),
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
        onTap: _onItemTapped,
      ),
    );
  }
}
