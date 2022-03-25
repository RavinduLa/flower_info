/*
  @author IT19240848 - H.G. Malwatta
 */

class FertilizerWithId {
  final String documentId;
  final String brandName;
  final String type;
  final String nitrogienValue;
  final String phosporosValue;
  final String potasiamValue;
  final String description;
  final String image;

  const FertilizerWithId({
    required this.documentId,
    required this.brandName,
    required this.type,
    required this.nitrogienValue,
    required this.phosporosValue,
    required this.potasiamValue,
    required this.description,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
    'documentId': documentId,
    'brandName': brandName,
    'type': type,
    'nitrogienValue': nitrogienValue,
    'phosporosValue': phosporosValue,
    'potasiamValue': potasiamValue,
    'description': description,
    'image': image,
  };

  static FertilizerWithId fromJson(Map<String, dynamic> json) => FertilizerWithId(
    documentId: json['documentId'],
    brandName: json['brandName'],
    type: json['type'],
    nitrogienValue: json['nitrogienValue'],
    phosporosValue: json['phosporosValue'],
    potasiamValue: json['potasiamValue'],
    description: json['description'],
    image: json['image'],
  );

  Map<String, dynamic> toJsonForUpdate() => {
    'documentId': documentId,
    'brandName': brandName,
    'type': type,
    'nitrogienValue': nitrogienValue,
    'phosporosValue': phosporosValue,
    'potasiamValue': potasiamValue,
    'description': description,
    'image': image,
  };
}
