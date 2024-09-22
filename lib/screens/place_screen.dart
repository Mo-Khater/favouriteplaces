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
        ],
      ),
    );
  }
}
