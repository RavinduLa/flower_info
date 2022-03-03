import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class ThemeAlert extends StatefulWidget {
  const ThemeAlert({Key? key}) : super(key: key);

  @override
  _ThemeAlertState createState() => _ThemeAlertState();
}

class _ThemeAlertState extends State<ThemeAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Theme'),
      content: const Text('Select your theme'),
      elevation: 24,
      alignment: Alignment.center,
      actions: [
        TextButton(
            onPressed: () {
              final provider =
              Provider.of<ThemeProvider>(context, listen: false);
              provider.changeTheme('system');
            },
            child: const Text('System Default')),
        TextButton(
            onPressed: () {
              final provider =
              Provider.of<ThemeProvider>(context, listen: false);
              provider.changeTheme('light');
            },
            child: const Text('Light Theme')),
        TextButton(
            onPressed: () {
              final provider =
              Provider.of<ThemeProvider>(context, listen: false);
              provider.changeTheme('dark');
            },
            child: const Text('Dark Theme')),
      ],
      backgroundColor: Theme.of(context).primaryColor,
      //shape: CircleBorder(),
    );
  }
}
