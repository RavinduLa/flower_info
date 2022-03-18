import 'package:cloud_firestore/cloud_firestore.dart';

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
    )).toList());
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
}

class FertilizerSingleView {
  final FertilizerWithId fertilizer;

  FertilizerSingleView(this.fertilizer);
}
