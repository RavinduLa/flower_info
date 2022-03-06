import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flower_info/models/disease_model.dart';

class DiseaseApi {
  static Future<DocumentReference> addDisease(Disease disease) {
    return FirebaseFirestore.instance.collection('diseases').add(
      <String, dynamic>{
        'name': disease.name,
        'look': disease.look,
        'cause': disease.cause,
        'treat': disease.treat,
        'prevent': disease.prevent,
        'image': disease.image,
      },
    );
  }
}
