import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/fertilizer_model.dart';

class FertilizerApi {
  static Future<DocumentReference> addFertilizer(Fertilizer fertilizer) {
    return FirebaseFirestore.instance
        .collection('fertilizer')
        .add(fertilizer.toJson());
  }

}