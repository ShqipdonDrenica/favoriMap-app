import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart' as latLng;

// Define the states
abstract class MapState {}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final latLng.LatLng point;
  final String address;

  MapLoaded(this.point, this.address);
}

class MapError extends MapState {
  final String message;

  MapError(this.message);
}

// Define the events
abstract class MapEvent {}

class SearchPlace extends MapEvent {
  final String query;

  SearchPlace(this.query);
}

class TapPlace extends MapEvent {
  final latLng.LatLng point;

  TapPlace(this.point);
}

// Define the BLoC
class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    on<SearchPlace>(_onSearchPlace);
    on<TapPlace>(_onTapPlace);
  }

  Future<void> _onSearchPlace(SearchPlace event, Emitter<MapState> emit) async {
    emit(MapLoading());
    try {
      List<Location> locations = await locationFromAddress(event.query);
      if (locations.isNotEmpty) {
        final location = locations.first;
        final newPoint = latLng.LatLng(location.latitude, location.longitude);
        final address = await _getAddress(newPoint);
        emit(MapLoaded(newPoint, address));
      } else {
        emit(MapError("No location found"));
      }
    } catch (e) {
      emit(MapError("Error occurred while searching for place: $e"));
    }
  }

  Future<void> _onTapPlace(TapPlace event, Emitter<MapState> emit) async {
    emit(MapLoading());
    try {
      final address = await _getAddress(event.point);
      emit(MapLoaded(event.point, address));
    } catch (e) {
      emit(MapError("Error occurred while fetching address: $e"));
    }
  }

  Future<String> _getAddress(latLng.LatLng point) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(point.latitude, point.longitude);
    if (placemarks.isNotEmpty) {
      return "${placemarks.first.country}, ${placemarks.first.locality}, ${placemarks.first.street}";
    } else {
      return "No address found";
    }
  }
}
