import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function(File image) onSelectImage;
  const ImageInput({super.key, required this.onSelectImage});
  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  void _takeImage() async {
    final imagePicker = ImagePicker();

    final takenImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxHeight: 600);

    if (takenImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(takenImage.path);
    });

    widget.onSelectImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ElevatedButton.icon(
      onPressed: _takeImage,
      label: const Text('take a pic'),
      icon: const Icon(Icons.camera),
    );
    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takeImage,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(.2),
        ),
      ),
      alignment: Alignment.center,
      child: content,
    );
  }
}
