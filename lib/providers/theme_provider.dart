import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    initializeTheme();
  }

  ThemeMode themeMode = ThemeMode.light;
  String selectedTheme = "Light";

//this method reads the shared preferences and gets the saved theme and sets it ti theme mode
//if no theme saved found, system default is used.
  initializeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    var savedTheme = prefs.getString('theme') ?? 'noTheme';

    if (savedTheme == 'System Default') {
      selectedTheme = "System Default";
      themeMode = ThemeMode.system;
    } else if (savedTheme == 'Dark') {
      selectedTheme = "Dark";
      themeMode = ThemeMode.dark;
    } else if (savedTheme == 'Light') {
      selectedTheme = "Light";
      themeMode = ThemeMode.light;
    } else {
      print('No theme found saved. Switching to system default');
      selectedTheme = "System Default";
      themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

//method called when user changes the theme.
  changeTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    if (theme == "system") {
      themeMode = ThemeMode.system;
      selectedTheme = "System Default";
      prefs.setString('theme', selectedTheme);
    } else if (theme == "dark") {
      themeMode = ThemeMode.dark;
      selectedTheme = "Dark";
      prefs.setString('theme', selectedTheme);
    } else {
      themeMode = ThemeMode.light;
      selectedTheme = "Light";
      prefs.setString('theme', selectedTheme);
    }
    notifyListeners();
  }
}

class CustomTheme {
  //Color primarySwatchDark = const Color(0xffff7700);
  //MaterialColor primarySwatchDark = const Color(0xffff7700);

  final DrawerThemeData lightDrawer = const DrawerThemeData(
      backgroundColor: Color(0xffFFF4F4), scrimColor: Colors.blue);

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[900],
    primarySwatch: Colors.green,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(
        secondary: Colors.green, secondaryVariant: Colors.grey),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xff074515),
    ),
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      //bodyText1: TextStyle(color: Colors.white),
      headline1: TextStyle(
          fontSize: 150, color: Colors.white, fontWeight: FontWeight.bold),
      headline2: TextStyle(
          color: Colors.limeAccent, fontSize: 50, fontWeight: FontWeight.bold),
      headline3: TextStyle(color: Colors.white, fontSize: 40),
      headline5: TextStyle(color: Colors.limeAccent, fontSize: 15),
    ),
    //iconTheme: const IconThemeData(color: Colors.white),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
      foregroundColor: Colors.green,
      splashColor: Colors.grey,
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.green,
    primaryColor: Colors.green,
    bottomAppBarColor: Colors.green,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.green, foregroundColor: Colors.black),
    colorScheme: const ColorScheme.light(
        secondary: Colors.white, secondaryVariant: Colors.black26),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xffdeffe8),
    ),
    brightness: Brightness.light,
    cardColor: Color(0xffFFF4F4),
    textTheme: const TextTheme(
      //bodyText1: TextStyle(color: Colors.white),
      headline1: TextStyle(
          fontSize: 150, color: Colors.black, fontWeight: FontWeight.bold),
      headline2: TextStyle(
          color: Colors.blueGrey, fontSize: 50, fontWeight: FontWeight.bold),
      headline3: TextStyle(color: Colors.black, fontSize: 40),
      headline5: TextStyle(color: Colors.blueGrey, fontSize: 15),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
      foregroundColor: Colors.black,
      splashColor: Colors.white,
    ),
  );
}
