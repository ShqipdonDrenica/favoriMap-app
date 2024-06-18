class PlaceModel {
  final String photoUrl;
  final String name;

  PlaceModel({required this.photoUrl, required this.name});

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      photoUrl: json['photoUrl'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'photoUrl': photoUrl,
      'name': name,
    };
  }
}
