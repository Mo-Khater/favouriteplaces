import 'package:favouriteplaces/models/place.dart';
import 'package:flutter/material.dart';

class PlaceScreen extends StatelessWidget {
  final Place place;
  const PlaceScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage:
                        AssetImage('lib/assets/images/profilephoto.jpg'),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black54],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    child: Text(
                      place.placeLocation.address,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
