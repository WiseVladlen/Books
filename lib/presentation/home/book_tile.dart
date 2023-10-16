import 'package:books/domain/model/book_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  const BookTile({
    super.key,
    required this.title,
    this.authors,
    this.pageCount,
    this.publisher,
    this.publishedDate,
    required this.description,
    required this.imageLink,
    required this.language,
  });

  final String title;
  final List<String>? authors;
  final int? pageCount;
  final String? publisher;
  final DateTime? publishedDate;
  final String? description;
  final String? imageLink;
  final String language;

  factory BookTile.fromModel(BookModel model) {
    return BookTile(
      key: ValueKey(model.id),
      title: model.title,
      authors: model.authors,
      pageCount: model.pageCount,
      publisher: model.publisher,
      publishedDate: model.publishedDate,
      description: model.description,
      imageLink: model.imageLink,
      language: model.language,
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = imageLink;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 96,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(0, 2),
                  spreadRadius: 2,
                  blurRadius: 4,
                ),
              ],
            ),
            child: imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (_, __) => _buildPlaceholder(),
                    errorWidget: (_, __, ___) => _buildPlaceholder(),
                    fadeOutDuration: const Duration(milliseconds: 250),
                    fadeInDuration: const Duration(milliseconds: 125),
                  )
                : _buildPlaceholder(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: title,
                    children: [
                      if (publishedDate case DateTime date) TextSpan(text: ' · (${date.year})')
                    ],
                  ),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        if (authors case List<String> authors)
                          TextSpan(text: 'Authors: ${authors.join(', ')}\n'),
                        if (publisher case String publisher)
                          TextSpan(text: 'Publisher: $publisher\n'),
                        if (pageCount case int pageCount)
                          TextSpan(text: 'Page count: $pageCount\n'),
                        TextSpan(text: 'Language: $language'),
                      ],
                    ),
                  ),
                ),
                if (description case String description)
                  Text(
                    description,
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return const Image(
      height: 96,
      image: AssetImage('assets/book-cover-placeholder.jpg'),
      fit: BoxFit.cover,
    );
  }
}
