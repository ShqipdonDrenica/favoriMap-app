import 'package:favori_map/src/features/dashboard/blocs/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

class MapViewPage extends StatelessWidget {
  final String? initialSearchQuery;

  const MapViewPage({Key? key, this.initialSearchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MapBloc()..add(SearchPlace(initialSearchQuery ?? '')),
      child: MapView(),
    );
  }
}

class MapView extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              latLng.LatLng point = latLng.LatLng(49.5, -0.09);
              String address = "Search for your location";

              if (state is MapLoaded) {
                point = state.point;
                address = state.address;
                mapController.move(point, 10.0);
              } else if (state is MapError) {
                address = state.message;
              }

              return FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  onTap: (tapPosition, p) {
                    context.read<MapBloc>().add(TapPlace(p));
                  },
                  center: point,
                  zoom: 5.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: point,
                        builder: (ctx) => const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(16.0),
                            hintText: "Search for your location",
                            prefixIcon: Icon(Icons.location_on_outlined),
                          ),
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              context.read<MapBloc>().add(SearchPlace(value));
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          if (_searchController.text.isNotEmpty) {
                            context
                                .read<MapBloc>()
                                .add(SearchPlace(_searchController.text));
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<MapBloc, MapState>(
                      builder: (context, state) {
                        String address = "Search for your location";
                        if (state is MapLoaded) {
                          address = state.address;
                        } else if (state is MapError) {
                          address = state.message;
                        }
                        return Text(address);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
