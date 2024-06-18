import 'package:equatable/equatable.dart';
import 'package:favori_map/src/features/dashboard/models/place_model.dart';

abstract class FavoritePlacesState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoritePlacesInitial extends FavoritePlacesState {}

class FavoritePlacesLoaded extends FavoritePlacesState {
  final List<PlaceModel> favoritePlaces;

  FavoritePlacesLoaded(this.favoritePlaces);

  @override
  List<Object> get props => [favoritePlaces];
}

class FavoritePlacesError extends FavoritePlacesState {
  final String message;

  FavoritePlacesError(this.message);

  @override
  List<Object> get props => [message];
}
