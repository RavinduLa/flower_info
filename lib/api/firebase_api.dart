import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flower_info/models/flower_model_with_id.dart';
import 'package:flutter/foundation.dart';

import '../models/flower_model.dart';

class FirebaseApi {
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

  static Future<void> editFlower(FlowerWithId flowerWithId) {
    return FirebaseFirestore.instance
        .collection('flowers')
        .doc(flowerWithId.documentId)
        .update(
          {
            'commonName': flowerWithId.commonName,
            'scientificName': flowerWithId.scientificName,
            'matureSize': flowerWithId.matureSize,
            'nativeRegion': flowerWithId.nativeRegion,
            'imageLink': flowerWithId.imageLink
          },
        )
        .then((value) => print("Flower Updated"))
        .catchError(
          (error) => print("Failed to update flower"),
        );
  }

  static Future<void> deleteFlower(String id) {
    return FirebaseFirestore.instance
        .collection('flowers')
        .doc(id)
        .delete()
        .then((value) => print('Flower deleted'))
        .catchError(
          (error) => print('Failed to delete flower'),
        );
  }

  static Stream<List<Flower>> get flowers {
    return FirebaseFirestore.instance
        .collection('flowers')
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map(
              (DocumentSnapshot documentSnapshot) => Flower(
                commonName: documentSnapshot.data()!['commonName'],
                scientificName: documentSnapshot.data()!['scientificName'],
                matureSize: documentSnapshot.data()!['matureSize'],
                nativeRegion: documentSnapshot.data()!['nativeRegion'],
                imageLink: documentSnapshot.data()!['imageLink'],
              ),
            )
            .toList());
  }

  static Stream<List<FlowerWithId>> get flowersWithId {
    return FirebaseFirestore.instance
        .collection('flowers')
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map(
              (DocumentSnapshot documentSnapshot) => FlowerWithId(
                documentId: documentSnapshot.id,
                commonName: documentSnapshot.data()!['commonName'],
                scientificName: documentSnapshot.data()!['scientificName'],
                matureSize: documentSnapshot.data()!['matureSize'],
                nativeRegion: documentSnapshot.data()!['nativeRegion'],
                imageLink: documentSnapshot.data()!['imageLink'],
              ),
            )
            .toList());
  }

  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Firebase Exception : ' + e.toString());
      }
      return null;
    }
  }

  static void getFlowersTest() async {
    print('running get flowers test');
    List<String> idList = [];
    QuerySnapshot querySnapshot;
    try {
      querySnapshot =
          await FirebaseFirestore.instance.collection('flowers').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          print("Id : " + doc.id);
        }
      } else {
        print('querysnapshot is empty');
      }
    } on Exception catch (e) {
      print(e);
    }

    print(idList.length);
    /*FirebaseFirestore.instance.collection('flowers').snapshots().map(
          (QuerySnapshot querySnapshot) => querySnapshot.docs.map(
            (DocumentSnapshot documentSnapshot) {
              print('id : '  + documentSnapshot.reference.id.toString());
            },
          ),
        );*/
  }

  static void testEditFlower(String id) {
    String uid = "8w1RADaFYEI1HUiPGZ1H";
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('flowers');
    collectionReference
        .doc(uid)
        .update({'commonName': 'Wathusudu'})
        .then((value) => print('Flower updated'))
        .catchError((error) => print("Error updating flower : $error"));
  }
}
