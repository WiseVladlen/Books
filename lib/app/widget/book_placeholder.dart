import 'package:flutter/material.dart';

class BookPlaceholder extends StatelessWidget {
  const BookPlaceholder({
    super.key,
    required this.image,
    required this.height,
    this.fit = BoxFit.cover,
  });

  final ImageProvider image;

  final double height;

  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      height: height,
      fit: fit,
    );
  }
}
