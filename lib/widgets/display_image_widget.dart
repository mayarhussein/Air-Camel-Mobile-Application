import 'dart:io';

import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  // Constructor
  const DisplayImage({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Colors.transparent;

    return Center(
        child: Stack(children: [
      buildImage(color),
      Positioned(
        child: buildEditIcon(color),
        right: 4,
        top: 10,
      )
    ]));
  }

  // Builds Profile Image
  Widget buildImage(Color color) {
    final image = NetworkImage(imagePath);

    return CircleAvatar(
      backgroundImage: image as ImageProvider,
      radius: 90,
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => buildCircle(
          child: IconButton(
        onPressed: onPressed,
        iconSize: 20,
        icon: Icon(Icons.edit),
      ));

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
  }) =>
      ClipOval(
          child: Container(
        color: Colors.white,
        child: child,
      ));
}
