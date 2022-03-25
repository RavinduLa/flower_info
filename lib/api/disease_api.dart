/*
* IT19180526 (S.A.N.L.D. Chandrasiri)
*
* Note : No code was copied in this project
* Where references are added, no code was directly copied from the reference.
* Instead the reference was used to get the idea about the task
* and implementation was done in our own way by us.
* This is our own work.
*
* Firebase firestore
* https://firebase.flutter.dev/docs/firestore/usage
* https://youtu.be/wUSkeTaBonA
* https://youtu.be/21vHY9P90jE
* https://youtu.be/G4INTsatBew
* https://youtu.be/w3krSTSGmaw
*
* Firebase storage
* https://youtu.be/dmZ9Tg9k13U
*
* */

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flower_info/models/diseases/disease_model.dart';
import 'package:flower_info/models/diseases/disease_model_id.dart';

class DiseaseApi {
  static Future<DocumentReference> addDisease(Disease disease) {
    return FirebaseFirestore.instance
        .collection('diseases')
        .add(disease.toJson());
  }

  static Stream<List<Disease>> readDisease() {
    return FirebaseFirestore.instance.collection('diseases').snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((doc) => Disease.fromJson(doc.data()))
            .toList());
  }

  static Stream<List<DiseaseWithId>> readDiseaseWithId() {
    return FirebaseFirestore.instance
        .collection('diseases')
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot doc) => DiseaseWithId(
                  documentId: doc.id,
                  name: doc.data()!['name'],
                  look: doc.data()!['look'],
                  cause: doc.data()!['cause'],
                  treat: doc.data()!['treat'],
                  prevent: doc.data()!['prevent'],
                  image: doc.data()!['image'],
                  created: doc.data()!['created'],
                ))
            .toList());
  }

  static Future<void> updateDisease(DiseaseWithId disease) {
    return FirebaseFirestore.instance
        .collection('diseases')
        .doc(disease.documentId)
        .update(disease.toJsonForUpdate())
        .then((value) => print('Disease Update Success!'))
        .catchError((error) => print('Disease Update Error: $error'));
  }

  static Future<void> deleteDisease(DiseaseWithId disease) {
    return FirebaseFirestore.instance
        .collection('diseases')
        .doc(disease.documentId)
        .delete()
        .then((value) => print('Disease Delete Success!'))
        .catchError((error) => print('Disease Delete Error: $error'));
  }

  static UploadTask? uploadImage(String id, File file) {
    try {
      final ref = FirebaseStorage.instance.ref('disease_images/$id');
      if (kDebugMode) {
        print('Disease Image Upload Success!');
      }
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
        .collection('diseases')
        .doc(documentId)
        .update({'image': link})
        .then((value) => print("Disease Image Link Updated"))
        .catchError((error) => print("Failed to update Image Link: $error"));
  }
}
