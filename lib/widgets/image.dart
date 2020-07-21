import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final image;

  const ImageScreen(this.image);

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: Center(
          child: image,
        ),
        onTap: () => Navigator.pop(context),
      );
}
