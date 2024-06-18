class PlaceModel {
  final String photoUrl;
  final String name;

  PlaceModel({required this.photoUrl, required this.name});

  factory PlaceModel.fromMap(Map<String, dynamic> json) => PlaceModel(
        photoUrl: json['photoUrl'],
        name: json['name'],
      );

  Map<String, dynamic> toMap() {
    return {
      'photoUrl': photoUrl,
      'name': name,
    };
  }
}
