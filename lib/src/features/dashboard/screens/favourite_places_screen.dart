import 'package:favori_map/src/features/dashboard/screens/map_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:favori_map/src/features/dashboard/blocs/favourite_places_bloc.dart';
import 'package:favori_map/src/features/dashboard/blocs/favourite_places_event.dart';
import 'package:favori_map/src/features/dashboard/blocs/favourite_places_state.dart';
import 'package:favori_map/src/features/dashboard/models/place_model.dart';

class FavoritePlacesScreen extends StatelessWidget {
  final _photoUrlController = TextEditingController();
  final _nameController = TextEditingController();

  FavoritePlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Places'),
      ),
      body: BlocBuilder<FavoritePlacesBloc, FavoritePlacesState>(
        builder: (context, state) {
          if (state is FavoritePlacesInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritePlacesLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _photoUrlController,
                    decoration: const InputDecoration(labelText: 'Photo URL'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final photoUrl = _photoUrlController.text;
                    final name = _nameController.text;

                    if (photoUrl.isNotEmpty && name.isNotEmpty) {
                      final place = PlaceModel(photoUrl: photoUrl, name: name);
                      context.read<FavoritePlacesBloc>().add(AddPlace(place));
                      _photoUrlController.clear();
                      _nameController.clear();
                    }
                  },
                  child: const Text('Add Place'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.favoritePlaces.length,
                    itemBuilder: (context, index) {
                      final place = state.favoritePlaces[index];
                      return ListTile(
                        leading: Image.network(
                          place.photoUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(place.name),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Image.asset('assets/map.png', height: 25),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapViewPage(
                                        initialSearchQuery: place.name),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _photoUrlController.text = place.photoUrl;
                                _nameController.text = place.name;
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text('Edit Place'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: _photoUrlController,
                                          decoration: const InputDecoration(
                                              labelText: 'Photo URL'),
                                        ),
                                        TextField(
                                          controller: _nameController,
                                          decoration: const InputDecoration(
                                              labelText: 'Name'),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          final editedPlace = PlaceModel(
                                            photoUrl: _photoUrlController.text,
                                            name: _nameController.text,
                                          );
                                          context
                                              .read<FavoritePlacesBloc>()
                                              .add(EditPlace(
                                                  index, editedPlace));
                                          _photoUrlController.clear();
                                          _nameController.clear();
                                          Navigator.of(ctx).pop();
                                        },
                                        child: const Text('Save'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                context
                                    .read<FavoritePlacesBloc>()
                                    .add(DeletePlace(index));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is FavoritePlacesError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
