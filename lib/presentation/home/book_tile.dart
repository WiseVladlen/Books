import 'package:books/domain/model/book_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  const BookTile({
    super.key,
    required this.title,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.imageLink,
    required this.language,
  });

  final String title;
  final List<String> authors;
  final String publisher;
  final DateTime publishedDate;
  final String description;
  final int pageCount;
  final String imageLink;
  final String language;

  factory BookTile.fromModel(BookModel model) {
    return BookTile(
      key: ValueKey(model.id),
      title: model.volumeInfo.title,
      authors: model.volumeInfo.authors,
      publisher: model.volumeInfo.publisher,
      publishedDate: model.volumeInfo.publishedDate,
      description: model.volumeInfo.description,
      pageCount: model.volumeInfo.pageCount,
      imageLink: model.volumeInfo.imageLink,
      language: model.volumeInfo.language,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            direction: Axis.vertical,
            spacing: 12,
            children: [
              Container(
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
                child: CachedNetworkImage(
                  imageUrl: imageLink,
                  height: 108,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => _buildPlaceholder(),
                  errorWidget: (_, __, ___) => _buildPlaceholder(),
                ),
              ),
              Text('$pageCount pages'),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title · (${publishedDate.year})',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Authors: $authors\n'
                    'Publisher: $publisher\n'
                    'Language: ${language.toUpperCase()}',
                  ),
                ),
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
      image: AssetImage('assets/book-cover-placeholder.jpg'),
    );
  }
}
