import 'package:books/app/app.dart';
import 'package:books/domain/model/model.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  const BookTile({
    super.key,
    required this.title,
    this.authors = const <String>[],
    this.pageCount,
    this.publisher = '',
    this.publishedDate,
    this.description = '',
    this.imageLink = '',
    required this.language,
  });

  factory BookTile.fromModel(BookModel model) {
    return BookTile(
      key: ValueKey<String>(model.id),
      title: model.title,
      authors: model.authors,
      pageCount: model.pageCount,
      publisher: model.publisher ?? '',
      publishedDate: model.publishedDate,
      description: model.description ?? '',
      imageLink: model.imageLink ?? '',
      language: model.language,
    );
  }

  final String title;
  final List<String> authors;
  final int? pageCount;
  final String publisher;
  final DateTime? publishedDate;
  final String description;
  final String imageLink;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: SizedBox(
              width: 96,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(0, 2),
                      spreadRadius: 2,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: imageLink.isNotEmpty
                    ? CustomNetworkImage(imageLink: imageLink)
                    : const BookPlaceholder(height: 96),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text.rich(
                    TextSpan(
                      text: title,
                      children: <InlineSpan>[
                        if (publishedDate case final DateTime date)
                          TextSpan(text: ' · (${date.year})'),
                      ],
                    ),
                    style: context.textStyles.cardTitleMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          if (authors.isNotEmpty)
                            context.l10n.authorsHeader.combineWith(authors.toFormattedString()),
                          if (publisher.isNotEmpty)
                            context.l10n.publisherHeader.combineWith(publisher),
                          if (pageCount case final int pageCount)
                            context.l10n.pageCountHeader.combineWith(pageCount),
                          context.l10n.languageHeader.combineWith(language, endSymbol: ''),
                        ],
                      ),
                    ),
                  ),
                  if (description.isNotEmpty)
                    Text(
                      description,
                      maxLines: 5,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}