/*
* IT19180526 (S.A.N.L.D. Chandrasiri)
*/

class Disease {
  final String name;
  final String look;
  final String cause;
  final String treat;
  final String prevent;
  final String image;
  final String created;

  const Disease({
    required this.name,
    required this.look,
    required this.cause,
    required this.treat,
    required this.prevent,
    required this.image,
    required this.created,
  });

  static Disease fromJson(Map<String, dynamic> json) => Disease(
        name: json['name'],
        look: json['look'],
        cause: json['cause'],
        treat: json['treat'],
        prevent: json['prevent'],
        image: json['image'],
        created: json['created'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'look': look,
        'cause': cause,
        'treat': treat,
        'prevent': prevent,
        'image': image,
        'created': created,
      };

  Map<String, dynamic> toJsonForUpdate() => {
        'name': name,
        'look': look,
        'cause': cause,
        'treat': treat,
        'prevent': prevent,
        'image': image,
        'created': created,
      };
}
