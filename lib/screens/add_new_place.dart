import 'dart:io';
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:path/path.dart' as path;
import 'package:favouriteplaces/models/place.dart';
import 'package:favouriteplaces/providers/place_provider.dart';
import 'package:favouriteplaces/widgets/image_input.dart';
import 'package:favouriteplaces/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewPlace extends ConsumerStatefulWidget {
  const AddNewPlace({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddNewPlace();
  }
}

class _AddNewPlace extends ConsumerState<AddNewPlace> {
  String? _title;
  File? _selectedImage;
  PlaceLocation? _placeLocation;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _saveItem(WidgetRef ref, BuildContext context) async {
    if (_selectedImage == null || _placeLocation == null) return;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final pathDic =await sysPath.getApplicationDocumentsDirectory();
      final fileName = path.basename(_selectedImage!.path);

      final copiedImage = await _selectedImage!.copy('${pathDic.path}/$fileName');
      ref.read(placeNotifierProvider.notifier).addPlace(
            Place(
                title: _title!,
                image: copiedImage,
                placeLocation: _placeLocation!),
          );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'this field can not be null';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _title = newValue;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ImageInput(onSelectImage: (File image) {
                  _selectedImage = image;
                }),
                const SizedBox(
                  height: 10,
                ),
                LocationInput(
                  onSelectPlaceLocation: (PlaceLocation placeLocation) {
                    _placeLocation = placeLocation;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _saveItem(ref, context);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Place'),
                ),
              ],
            )),
      ),
    );
  }
}
