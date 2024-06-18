// import 'package:favori_map/shared_preferences.dart';
// import 'package:flutter/material.dart';
// import 'map_view_page.dart';
// import 'place_model.dart';

// class FavoritePlacesScreen extends StatefulWidget {
//   @override
//   _FavoritePlacesScreenState createState() => _FavoritePlacesScreenState();
// }

// class _FavoritePlacesScreenState extends State<FavoritePlacesScreen> {
//   final PreferencesHelper _prefsHelper = PreferencesHelper();
//   List<PlaceModel> _favoritePlaces = [];

//   final _photoUrlController = TextEditingController();
//   final _nameController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadPlaces();
//   }

//   Future<void> _loadPlaces() async {
//     try {
//       final data = await _prefsHelper.getPlaces();
//       setState(() {
//         _favoritePlaces = data;
//       });
//     } catch (error) {
//       // Handle the error appropriately
//       print("Error loading places: $error");
//     }
//   }

//   Future<void> _savePlaces() async {
//     try {
//       await _prefsHelper.savePlaces(_favoritePlaces);
//     } catch (error) {
//       // Handle the error appropriately
//       print("Error saving places: $error");
//     }
//   }

//   void _addFavoritePlace() {
//     final photoUrl = _photoUrlController.text;
//     final name = _nameController.text;

//     if (photoUrl.isNotEmpty && name.isNotEmpty) {
//       setState(() {
//         _favoritePlaces.add(PlaceModel(photoUrl: photoUrl, name: name));
//       });
//       _photoUrlController.clear();
//       _nameController.clear();
//       _savePlaces();
//     }
//   }

//   void _editFavoritePlace(int index) {
//     _photoUrlController.text = _favoritePlaces[index].photoUrl;
//     _nameController.text = _favoritePlaces[index].name;

//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text('Edit Place'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _photoUrlController,
//               decoration: InputDecoration(labelText: 'Photo URL'),
//             ),
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//           ],
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 _favoritePlaces[index] = PlaceModel(
//                   photoUrl: _photoUrlController.text,
//                   name: _nameController.text,
//                 );
//               });
//               _photoUrlController.clear();
//               _nameController.clear();
//               Navigator.of(ctx).pop();
//               _savePlaces();
//             },
//             child: Text('Save'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _deleteFavoritePlace(int index) {
//     setState(() {
//       _favoritePlaces.removeAt(index);
//     });
//     _savePlaces();
//   }

//   void _navigateToMapView(String placeName) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => MapViewPage(initialSearchQuery: placeName),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorite Places'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _photoUrlController,
//               decoration: InputDecoration(labelText: 'Photo URL'),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: _addFavoritePlace,
//             child: Text('Add Place'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _favoritePlaces.length,
//               itemBuilder: (context, index) {
//                 final place = _favoritePlaces[index];
//                 return ListTile(
//                   leading: Image.network(place.photoUrl,
//                       width: 50, height: 50, fit: BoxFit.cover),
//                   title: Text(place.name),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: Image.asset('assets/map.png', height: 25),
//                         onPressed: () => _navigateToMapView(place.name),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.edit),
//                         onPressed: () => _editFavoritePlace(index),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.delete),
//                         onPressed: () => _deleteFavoritePlace(index),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
