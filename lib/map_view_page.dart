// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:latlong2/latlong.dart' as latLng;

// class MapViewPage extends StatefulWidget {
//   final String? initialSearchQuery;

//   const MapViewPage({Key? key, this.initialSearchQuery}) : super(key: key);

//   @override
//   State<MapViewPage> createState() => _MapViewPageState();
// }

// class _MapViewPageState extends State<MapViewPage> {
//   double long = 49.5;
//   double lat = -0.09;
//   latLng.LatLng point = latLng.LatLng(49.5, -0.09);
//   String address = "Search for your location";
//   final TextEditingController _searchController = TextEditingController();

//   late MapController mapController;

//   @override
//   void initState() {
//     super.initState();
//     mapController = MapController();
//     if (widget.initialSearchQuery != null) {
//       _searchPlace(widget.initialSearchQuery!);
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   Future<void> _searchPlace(String query) async {
//     try {
//       List<Location> locations = await locationFromAddress(query);
//       if (locations.isNotEmpty) {
//         final location = locations.first;
//         final newPoint = latLng.LatLng(location.latitude, location.longitude);

//         setState(() {
//           point = newPoint;
//           long = location.longitude;
//           lat = location.latitude;
//           _updateAddress(newPoint);
//         });

//         // Move the map to the new location
//         mapController.move(newPoint, 10.0);
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error occurred while searching for place: $e");
//       }
//     }
//   }

//   Future<void> _updateAddress(latLng.LatLng p) async {
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(p.latitude, p.longitude);
//     setState(() {
//       if (placemarks.isNotEmpty) {
//         address =
//             "${placemarks.first.country}, ${placemarks.first.locality}, ${placemarks.first.street}";
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         FlutterMap(
//           mapController: mapController,
//           options: MapOptions(
//             onTap: (tapPosition, p) async {
//               List<Placemark> placemarks =
//                   await placemarkFromCoordinates(p.latitude, p.longitude);
//               setState(() {
//                 point = p;
//                 if (placemarks.isNotEmpty) {
//                   address =
//                       "${placemarks.first.country}, ${placemarks.first.locality}, ${placemarks.first.street}";
//                 }
//                 if (kDebugMode) {
//                   print(p);
//                 }
//               });
//               if (kDebugMode) {
//                 print(address);
//               }
//             },
//             center: latLng.LatLng(49.5, -0.09),
//             zoom: 5.0,
//           ),
//           layers: [
//             TileLayerOptions(
//               urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//               subdomains: ['a', 'b', 'c'],
//             ),
//             MarkerLayerOptions(
//               markers: [
//                 Marker(
//                   width: 80.0,
//                   height: 80.0,
//                   point: point,
//                   builder: (ctx) => const Icon(
//                     Icons.location_on,
//                     color: Colors.red,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Card(
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _searchController,
//                         decoration: const InputDecoration(
//                           contentPadding: EdgeInsets.all(16.0),
//                           hintText: "Search for your location",
//                           prefixIcon: Icon(Icons.location_on_outlined),
//                         ),
//                         onSubmitted: (value) {
//                           if (value.isNotEmpty) {
//                             _searchPlace(value);
//                           }
//                         },
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.search),
//                       onPressed: () {
//                         if (_searchController.text.isNotEmpty) {
//                           _searchPlace(_searchController.text);
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Text(address),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
