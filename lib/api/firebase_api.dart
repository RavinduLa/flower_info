import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../models/flower_model.dart';

class FirebaseApi{
  static Future<DocumentReference> addFlower(Flower flower) {
    return FirebaseFirestore.instance.collection('flowers').add(
      <String, dynamic>{
        'commonName': flower.commonName,
        'scientificName': flower.scientificName,
        'matureSize': flower.matureSize,
        'nativeRegion': flower.nativeRegion,
        'imageLink': flower.imageLink,
      },
    );
  }
}