import 'package:flower_info/components/theme_alert.dart';
import 'package:flower_info/screens/admin/admin_dashboard.dart';
import 'package:flower_info/screens/admin/admin_dashboard_checked.dart';
import 'package:flower_info/screens/diseases/diseases.dart';
import 'package:flower_info/screens/fertilizers/fertilizers.dart';
import 'package:flower_info/screens/flowers/flowers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

import '../providers/theme_provider.dart';

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
    _simpleConnectionChecker.onConnectionChange.listen((connected) {
      setState(() {
        isConnected = connected;
      });
    });
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

    emptyCache() {
      var result = DefaultCacheManager().emptyCache();
      result.whenComplete(
        () => showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Success"),
            content:
            const Text("Data has been reloaded successfully"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.green),
                ),
              )
            ],
          );
        })
      );
    }

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
            ListTile(
              title: const Text("Reload App"),
              subtitle: const Text("Clear cache and reload all data"),
              onTap: () {
                isConnected
                    ? emptyCache()
                    : showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("No Internet"),
                            content:
                                const Text("Cannot reload without internet"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "OK",
                                  style: TextStyle(color: Colors.green),
                                ),
                              )
                            ],
                          );
                        });
              },
            ),
          ],
        ),
      ),
      body: SizedBox.expand(
          child: Center(
        child: screens.elementAt(currentIndex),
      )),
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
