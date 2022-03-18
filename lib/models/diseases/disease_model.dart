class Disease {
  final String name;
  final String look;
  final String cause;
  final String treat;
  final String prevent;
  final String image;

  const Disease({
    required this.name,
    required this.look,
    required this.cause,
    required this.treat,
    required this.prevent,
    required this.image,
  });

  static Disease fromJson(Map<String, dynamic> json) => Disease(
        name: json['name'],
        look: json['look'],
        cause: json['cause'],
        treat: json['treat'],
        prevent: json['prevent'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
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
