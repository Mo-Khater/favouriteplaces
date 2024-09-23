import 'dart:io';

import 'package:uuid/uuid.dart';

class PlaceLocation {
  final double lat;
  final double lng;
  final String address;

  const PlaceLocation(
      {required this.lat, required this.lng, required this.address});
}

class Place {
  final String id;
  final String title;
  final File image;
  final PlaceLocation placeLocation;
  Place({required this.title, required this.image, required this.placeLocation})
      : id = const Uuid().v4();
}
