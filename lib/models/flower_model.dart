class Flower {
  final String commonName;
  final String scientificName;
  final String matureSize;
  final String nativeRegion;
  String imageLink = "not_provided";

  Flower({
    required this.commonName,
    required this.scientificName,
    required this.matureSize,
    required this.nativeRegion,
    //required this.imageLink
  });
}
