import 'package:flower_info/components/theme_alert.dart';
import 'package:flower_info/screens/admin/admin_dashboard.dart';
import 'package:flower_info/screens/diseases/diseases.dart';
import 'package:flower_info/screens/fertilizers/fertilizers.dart';
import 'package:flower_info/screens/flowers/flowers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int currentIndex = 0;
  final screens = [ FLowers(), const Fertilizers(), const Diseases()];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
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
                title: Text("Admin"),
                subtitle: Text("Admin Dashboard"),
                onTap: () {
                  Navigator.of(context).pushNamed(AdminDashboard.routeName);
                },
              )
            ],
          ),
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            children: screens,
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            //padding: EdgeInsets.all(30.0),
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      currentIndex = 0;

                      _pageController.animateToPage(currentIndex,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    });
                  },
                  icon: currentIndex == 0
                      ? Icon(
                          Icons.home_filled,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 35,
                        )
                      : Icon(
                          Icons.home_filled,
                          color: Theme.of(context).colorScheme.secondaryVariant,
                          size: 35,
                        ),
                ),
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      currentIndex = 1;

                      _pageController.animateToPage(currentIndex,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut);
                    });
                  },
                  icon: currentIndex == 1
                      ? Icon(
                          Icons.water_drop_rounded,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 35,
                        )
                      : Icon(
                          Icons.water_drop_rounded,
                          color: Theme.of(context).colorScheme.secondaryVariant,
                          size: 35,
                        ),
                ),
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      currentIndex = 2;

                      _pageController.animateToPage(currentIndex,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut);
                    });
                  },
                  icon: currentIndex == 2
                      ? Icon(
                          Icons.coronavirus,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 35,
                        )
                      : Icon(
                          Icons.coronavirus,
                          color: Theme.of(context).colorScheme.secondaryVariant,
                          size: 35,
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}
