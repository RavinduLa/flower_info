/*
  @author IT19240848 - H.G. Malwatta
 */


class Fertilizer {
  final String brandName;
  final String type;
  final String nitrogienValue;
  final String phosporosValue;
  final String potasiamValue;
  final String description;
  final String image;

  const Fertilizer({
    required this.brandName,
    required this.type,
    required this.nitrogienValue,
    required this.phosporosValue,
    required this.potasiamValue,
    required this.description,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
    'brandName': brandName,
    'type': type,
    'nitrogienValue': nitrogienValue,
    'phosporosValue': phosporosValue,
    'potasiamValue': potasiamValue,
    'description': description,
    'image': image,
  };

  static Fertilizer fromJson(Map<String, dynamic> json) => Fertilizer(
    brandName: json['brandName'],
    type: json['type'],
    nitrogienValue: json['nitrogienValue'],
    phosporosValue: json['phosporosValue'],
    potasiamValue: json['potasiamValue'],
    description: json['description'],
    image: json['image'],
  );

  Map<String, dynamic> toJsonForUpdate() => {
    'brandName': brandName,
    'type': type,
    'nitrogienValue': nitrogienValue,
    'phosporosValue': phosporosValue,
    'potasiamValue': potasiamValue,
    'description': description,
    'image': image,
  };
}
