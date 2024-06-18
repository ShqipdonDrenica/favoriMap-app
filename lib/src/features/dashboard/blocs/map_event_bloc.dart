// import 'package:bloc/bloc.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:latlong2/latlong.dart' as latLng;

// // Events
// abstract class MapEvent {}

// class SearchPlaceEvent extends MapEvent {
//   final String query;

//   SearchPlaceEvent(this.query);
// }

// // States
// abstract class MapState {}

// class MapInitial extends MapState {}

// class MapLoading extends MapState {}

// class MapLoaded extends MapState {
//   final latLng.LatLng point;
//   final String address;

//   MapLoaded(this.point, this.address);
// }

// class MapError extends MapState {
//   final String message;

//   MapError(this.message);
// }

// // Bloc
// class MapBloc extends Bloc<MapEvent, MapState> {
//   late latLng.LatLng point;
//   late String address;
//   final latLng.LatLng initialPoint = latLng.LatLng(49.5, -0.09);

//   MapBloc() : super(MapInitial());

//   @override
//   Stream<MapState> mapEventToState(MapEvent event) async* {
//     if (event is SearchPlaceEvent) {
//       yield MapLoading();
//       try {
//         List<Location> locations = await locationFromAddress(event.query);
//         if (locations.isNotEmpty) {
//           final location = locations.first;
//           point = latLng.LatLng(location.latitude, location.longitude);
//           await _updateAddress(point);
//           yield MapLoaded(point, address);
//         } else {
//           yield MapError("No location found for query: ${event.query}");
//         }
//       } catch (e) {
//         yield MapError("Error occurred while searching for place: $e");
//       }
//     }
//   }

//   Future<void> _updateAddress(latLng.LatLng p) async {
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(p.latitude, p.longitude);
//     if (placemarks.isNotEmpty) {
//       address =
//           "${placemarks.first.country}, ${placemarks.first.locality}, ${placemarks.first.street}";
//     }
//   }
// }
