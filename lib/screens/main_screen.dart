import 'dart:io';

import 'package:favouriteplaces/models/place.dart';
import 'package:favouriteplaces/providers/place_provider.dart';
import 'package:favouriteplaces/screens/add_new_place.dart';
import 'package:favouriteplaces/screens/place_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late Future<void> _places;

  @override
  void initState() {
    super.initState();
    _places = ref.read(placeNotifierProvider.notifier).loadData();
  }

  void removeItem(Place place) {
    ref.watch(placeNotifierProvider.notifier).removePlace(place);
  }

  @override
  Widget build(BuildContext context) {
    final List<Place> favPlaces = ref.watch(placeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) {
                    return AddNewPlace();
                  },
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
          future: _places,
          builder: (ctx, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : favPlaces.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: favPlaces.length,
                          itemBuilder: (ctx, index) {
                            return Dismissible(
                              key: ValueKey(favPlaces[index].id),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) {
                                        return PlaceScreen(
                                            place: favPlaces[index]);
                                      },
                                    ),
                                  );
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(favPlaces[index].image),
                                  ),
                                  title: Text(
                                    favPlaces[index].title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface),
                                  ),
                                  subtitle: Text(
                                    favPlaces[index].placeLocation.address,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface),
                                  ),
                                ),
                              ),
                              onDismissed: (direction) {
                                removeItem(favPlaces[index]);
                              },
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                          'No places try add one',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                        ),
                      );
          }),
    );
  }
}
