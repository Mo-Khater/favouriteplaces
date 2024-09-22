import 'package:favouriteplaces/models/place.dart';
import 'package:favouriteplaces/providers/place_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewPlace extends ConsumerWidget {
  String? _title;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AddNewPlace({super.key});

  void _saveItem(WidgetRef ref, BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      ref.read(placeNotifierProvider.notifier).addPlace(
            Place(title: _title!),
          );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  height: 5,
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
