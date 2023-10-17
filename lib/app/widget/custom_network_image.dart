import 'package:books/app/widget/book_placeholder.dart';
import 'package:books/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageLink,
    this.fadeOutDuration = const Duration(milliseconds: 250),
    this.fadeInDuration = const Duration(milliseconds: 125),
  });

  final String imageLink;

  final Duration fadeOutDuration;

  final Duration fadeInDuration;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageLink,
      placeholder: (_, __) => const BookPlaceholder(
        image: AssetImage(placeholderPath),
        height: 96,
      ),
      errorWidget: (_, __, ___) => const BookPlaceholder(
        image: AssetImage(placeholderPath),
        height: 96,
      ),
      fadeOutDuration: fadeOutDuration,
      fadeInDuration: fadeInDuration,
    );
  }
}
