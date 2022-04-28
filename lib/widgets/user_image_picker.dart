import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  // Passing parameters: This function will be called inside this widget but will get passed from outside this widget
  final void Function(File pickedImage)? imagePickFn;

  UserImagePicker(this.imagePickFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _ImageFile;

  void _pickImage() async {
    final pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _ImageFile = File(pickedImageFile!.path);
    });

    // will send the parameter to _pickedImage function in AuthForm
    widget.imagePickFn!(_ImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      TextButton.icon(
          style: TextButton.styleFrom(primary: Colors.red.shade300),
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text('Upload an image')),
      CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey,
        backgroundImage: _ImageFile != null ? FileImage(_ImageFile!) : null,
      ),
    ]);
  }
}
