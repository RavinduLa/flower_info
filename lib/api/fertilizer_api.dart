/*
* @author IT19240848 - H.G. Malwatta
*
* Note : No code was copied in this project
* Where references are added, no code was directly copied from the reference.
* Instead the reference was used to get the idea about the task
* and implementation was done in our own way by us.
* This is our own work.
*
* Firebase Firestore
* https://firebase.flutter.dev/docs/firestore/usage
* https://youtu.be/wUSkeTaBonA
*
* CRUD Operations
* https://youtu.be/21vHY9P90jE
* https://youtu.be/G4INTsatBew
* https://youtu.be/w3krSTSGmaw
*
* Firebase Storage
* https://youtu.be/dmZ9Tg9k13U
*
*
* */

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import '../models/fertilizer_model.dart';
import '../models/fertilizer_model_id.dart';

class FertilizerApi {
  static Future<DocumentReference> addFertilizer(Fertilizer fertilizer) {
    return FirebaseFirestore.instance
        .collection('fertilizers')
        .add(fertilizer.toJson());
  }

  static Stream<List<Fertilizer>> readFertilizer() {
    return FirebaseFirestore.instance.collection('fertilizers').snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((doc) => Fertilizer.fromJson(doc.data()))
            .toList());
  }

  static Stream<List<FertilizerWithId>> readFertilizerWithId() {
    return FirebaseFirestore.instance
        .collection('fertilizers')
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot doc) => FertilizerWithId(
                  documentId: doc.id,
                  brandName: doc.data()!['brandName'],
                  type: doc.data()!['type'],
                  nitrogienValue: doc.data()!['nitrogienValue'],
                  phosporosValue: doc.data()!['phosporosValue'],
                  potasiamValue: doc.data()!['potasiamValue'],
                  description: doc.data()!['description'],
                  image: doc.data()!['image'],
                ))
            .toList());
  }

  static Future<void> updateFertilizer(FertilizerWithId fertilizerWithId) {
    return FirebaseFirestore.instance
        .collection('fertilizers')
        .doc(fertilizerWithId.documentId)
        .update(fertilizerWithId.toJsonForUpdate())
        .then((value) => print('Fertilizer Update Success!'))
        .catchError((error) => print('Fertilizer Update Error: $error'));
  }

  static Future<void> deleteFertilizer(FertilizerWithId fertilizerWithId) {
    return FirebaseFirestore.instance
        .collection('fertilizers')
        .doc(fertilizerWithId.documentId)
        .delete()
        .then((value) => print('Fertilizer Delete Success!'))
        .catchError((error) => print('Fertilizer Delete Error: $error'));
  }

  static UploadTask? uploadImage(String id, File file) {
    try {
      final ref = FirebaseStorage.instance.ref('fertilizer_images/$id');
      return ref.putFile(file);
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print('Firebase Exception : ' + error.toString());
      }
      return null;
    }
  }

  static Future<void> updateImageLink(String documentId, String link) {
    return FirebaseFirestore.instance
        .collection('fertilizers')
        .doc(documentId)
        .update({'image': link})
        .then((value) => print("fertilizer Image Link Updated"))
        .catchError((error) => print("Failed to update Image Link: $error"));
  }
}

class FertilizerSingleView {
  final FertilizerWithId fertilizer;

  FertilizerSingleView(this.fertilizer);
}
