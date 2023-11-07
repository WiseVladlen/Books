import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';

class BookPlaceholder extends StatelessWidget {
  const BookPlaceholder({
    super.key,
    this.image = const AssetImage(Resources.ASSETS_BOOK_COVER_PLACEHOLDER_JPG),
    this.width = double.maxFinite,
    this.height = double.maxFinite,
    this.fit = BoxFit.cover,
  });

  final ImageProvider image;

  final double width;

  final double height;

  final BoxFit fit;

  @override
  Widget build(_) => Image(image: image, height: height, fit: fit);
}
