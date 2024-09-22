import 'dart:io';

import 'package:uuid/uuid.dart';

class Place {
  final String id;
  final String title;
  final File image;
  Place({required this.title,required this.image}) : id = const Uuid().v4();
}
