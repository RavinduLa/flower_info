class Disease {
  final String documentId;
  final String name;
  final String look;
  final String cause;
  final String treat;
  final String prevent;
  final String image;

  const Disease({
    required this.documentId,
    required this.name,
    required this.look,
    required this.cause,
    required this.treat,
    required this.prevent,
    required this.image,
  });

  static Disease fromJson(Map<String, dynamic> json) => Disease(
        documentId: json['documentId'],
        name: json['name'],
        look: json['look'],
        cause: json['cause'],
        treat: json['treat'],
        prevent: json['prevent'],
        image: json['image'],
      );
}
