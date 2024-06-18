import 'package:favori_map/shared_preferences.dart';
import 'package:favori_map/src/features/auth/models/user_model.dart';
import 'package:favori_map/src/features/dashboard/blocs/favourite_places_bloc.dart';
import 'package:favori_map/src/features/dashboard/blocs/favourite_places_event.dart';
import 'package:favori_map/src/features/dashboard/screens/favourite_places_screen.dart';
import 'package:favori_map/src/features/dashboard/screens/map_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileWidget extends StatelessWidget {
  final UserModel user;

  const UserProfileWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 60,
          ),
          if (user.profilePicture.isNotEmpty)
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.profilePicture),
            ),
          const SizedBox(width: 20),
          Text(
            '${user.firstName} ${user.lastName}',
            style: const TextStyle(fontSize: 20),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            user.email,
            style: const TextStyle(fontSize: 20),
            softWrap: true,
            overflow: TextOverflow.clip,
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MapViewPage()),
              );
            },
            child: const Text(
              'Go to map',
              style: TextStyle(color: Colors.red),
            ),
          ),
          const Text('Or'),
          ElevatedButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => FavoritePlacesBloc(PreferencesHelper())
                      ..add(LoadPlaces()),
                    child: FavoritePlacesScreen(),
                  ),
                ),
              );
            },
            child: const Text(
              'Go to favourite places',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
