import 'dart:io';

import 'package:favouriteplaces/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class PlaceNotifier extends StateNotifier<List<Place>> {
  PlaceNotifier() : super([]);

  Future<void> loadData() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'places'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT,image TEXT, lat REAL,lng REAL,address TEXT)');
      },
      version: 1,
    );

    final rows = await db.query('user_places');

    final places = rows
        .map((row) => Place(
            title: row['id'] as String,
            image: File(row['image'] as String),
            placeLocation: PlaceLocation(
                lat: row['lat'] as double,
                lng: row['lng'] as double,
                address: row['address'] as String)))
        .toList();
    state = places;
  }

  void addPlace(Place place) async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'places'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT,image TEXT, lat REAL,lng REAL,address TEXT)');
      },
      version: 1,
    );

    db.insert('user_places', {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'lat': place.placeLocation.lat,
      'lng': place.placeLocation.lng,
      'address': place.placeLocation.address
    });

    state = [...state, place];
  }

  void removePlace(Place place) {
    state = state.where((p) => p.id != place.id).toList();
  }
}

final placeNotifierProvider =
    StateNotifierProvider<PlaceNotifier, List<Place>>((ref) {
  return PlaceNotifier();
});
