import 'package:bloc/bloc.dart';
import 'package:favori_map/shared_preferences.dart';
import 'package:favori_map/src/features/dashboard/blocs/favourite_places_event.dart';
import 'package:favori_map/src/features/dashboard/blocs/favourite_places_state.dart';
import 'package:favori_map/src/features/dashboard/models/place_model.dart';
import 'package:flutter/foundation.dart';

class FavoritePlacesBloc
    extends Bloc<FavoritePlacesEvent, FavoritePlacesState> {
  final PreferencesHelper _prefsHelper;

  FavoritePlacesBloc(this._prefsHelper) : super(FavoritePlacesInitial()) {
    on<LoadPlaces>(_onLoadPlaces);
    on<AddPlace>(_onAddPlace);
    on<EditPlace>(_onEditPlace);
    on<DeletePlace>(_onDeletePlace);
  }

  Future<void> _onLoadPlaces(
      LoadPlaces event, Emitter<FavoritePlacesState> emit) async {
    try {
      final data = await _prefsHelper.getPlaces();
      emit(FavoritePlacesLoaded(data));
    } catch (error) {
      emit(FavoritePlacesError("Error loading places: $error"));
    }
  }

  void _onAddPlace(AddPlace event, Emitter<FavoritePlacesState> emit) {
    if (state is FavoritePlacesLoaded) {
      final updatedPlaces =
          List<PlaceModel>.from((state as FavoritePlacesLoaded).favoritePlaces)
            ..add(event.place);
      _prefsHelper.savePlaces(updatedPlaces); // Ensure places are saved
      emit(FavoritePlacesLoaded(updatedPlaces)); // Emit updated state
      if (kDebugMode) {
        print('Updated places: $updatedPlaces');
      } // Check if updated places are correct
    }
  }

  Future<void> _onEditPlace(
      EditPlace event, Emitter<FavoritePlacesState> emit) async {
    if (state is FavoritePlacesLoaded) {
      final updatedPlaces =
          List<PlaceModel>.from((state as FavoritePlacesLoaded).favoritePlaces)
            ..[event.index] = event.place;
      await _prefsHelper.savePlaces(updatedPlaces);
      emit(FavoritePlacesLoaded(updatedPlaces));
    }
  }

  Future<void> _onDeletePlace(
      DeletePlace event, Emitter<FavoritePlacesState> emit) async {
    if (state is FavoritePlacesLoaded) {
      final updatedPlaces =
          List<PlaceModel>.from((state as FavoritePlacesLoaded).favoritePlaces)
            ..removeAt(event.index);
      await _prefsHelper.savePlaces(updatedPlaces);
      emit(FavoritePlacesLoaded(updatedPlaces));
    }
  }
}
