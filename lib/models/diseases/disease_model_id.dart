class DiseaseWithId {
  final String documentId;
  final String name;
  final String look;
  final String cause;
  final String treat;
  final String prevent;
  final String image;

  const DiseaseWithId({
    required this.documentId,
    required this.name,
    required this.look,
    required this.cause,
    required this.treat,
    required this.prevent,
    required this.image,
  });

  static DiseaseWithId fromJson(Map<String, dynamic> json) => DiseaseWithId(
        documentId: json['documentId'],
        name: json['name'],
        look: json['look'],
        cause: json['cause'],
        treat: json['treat'],
        prevent: json['prevent'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'documentId': documentId,
        'name': name,
        'look': look,
        'cause': cause,
        'treat': treat,
        'prevent': prevent,
        'image': image,
      };

  Map<String, dynamic> toJsonForUpdate() => {
        'name': name,
        'look': look,
        'cause': cause,
        'treat': treat,
        'prevent': prevent,
        'image': image,
      };
}
