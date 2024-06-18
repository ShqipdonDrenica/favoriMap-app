import 'dart:convert';
import 'package:favori_map/src/features/dashboard/models/place_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String _keyPlaces = "places";

  Future<void> savePlaces(List<PlaceModel> places) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> placesJson =
        places.map((place) => json.encode(place.toJson())).toList();
    await prefs.setStringList(_keyPlaces, placesJson);
  }

  Future<List<PlaceModel>> getPlaces() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? placesJson = prefs.getStringList(_keyPlaces);
    if (placesJson != null) {
      return placesJson
          .map((place) => PlaceModel.fromJson(json.decode(place)))
          .toList();
    }
    return [];
  }
}
