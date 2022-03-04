import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_info/models/flower_model.dart';
import 'package:flutter/material.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  StreamSubscription<QuerySnapshot>? _flowerListSubscription;
  List<Flower> _flowers = [];
  List<Flower> get flowers => _flowers;

  void init() async {
    print('running init in application state');
    _flowerListSubscription = FirebaseFirestore.instance
        .collection('flowers')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      _flowers = [];
      for (final document in snapshot.docs) {
        _flowers.add(
          Flower(
            commonName: document.data()['commonName'] as String,
            scientificName: document.data()['scientificName'] as String,
            matureSize: document.data()['matureSize'] as String,
            nativeRegion: document.data()['nativeRegion'] as String,
            imageLink: document.data()['imageLink'] as String,
          ),
        );
      }
      notifyListeners();
    });
    print('flower: ' + _flowers.toString());
  }
}
