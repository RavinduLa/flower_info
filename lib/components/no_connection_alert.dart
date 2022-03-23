import 'package:flutter/material.dart';

class NoConnectionAlert extends StatefulWidget {
  const NoConnectionAlert({Key? key}) : super(key: key);

  @override
  _NoConnectionAlertState createState() => _NoConnectionAlertState();
}

class _NoConnectionAlertState extends State<NoConnectionAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("No Internet"),
      content: const Text(
          "Flower Info needs an active internet connection to work. Please connect to internet to load latest info"),
      elevation: 24,
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}
