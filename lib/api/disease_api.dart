import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_info/models/disease_model.dart';
import 'package:flower_info/models/disease_model_id.dart';

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
}

class DiseaseSingleView {
  final DiseaseWithId disease;

  DiseaseSingleView(this.disease);
}
