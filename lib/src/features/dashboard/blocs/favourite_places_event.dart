import 'package:equatable/equatable.dart';
import 'package:favori_map/src/features/dashboard/models/place_model.dart';

abstract class FavoritePlacesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadPlaces extends FavoritePlacesEvent {}

class AddPlace extends FavoritePlacesEvent {
  final PlaceModel place;

  AddPlace(this.place);

  @override
  List<Object> get props => [place];
}

class EditPlace extends FavoritePlacesEvent {
  final int index;
  final PlaceModel place;

  EditPlace(this.index, this.place);

  @override
  List<Object> get props => [index, place];
}

class DeletePlace extends FavoritePlacesEvent {
  final int index;

  DeletePlace(this.index);

  @override
  List<Object> get props => [index];
}
