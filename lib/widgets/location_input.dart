import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});
  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  Location? currentLocation;
  bool isGettingLocation = false;
  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isGettingLocation = true;
    });

    locationData = await location.getLocation();

    setState(() {
      isGettingLocation = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget review = Text(
      'No choosen location',
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
    );
    if (isGettingLocation) {
      review = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(.2),
              ),
            ),
            alignment: Alignment.center,
            child: review),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextButton.icon(
            onPressed: _getCurrentLocation,
            label: const Text('add current location'),
            icon: const Icon(Icons.location_on),
          ),
          TextButton.icon(
            onPressed: () {},
            label: const Text('get location on map'),
            icon: const Icon(Icons.map),
          )
        ])
      ],
    );
  }
}
