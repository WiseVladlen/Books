import 'package:books/app/widget/widget.dart';
import 'package:books/domain/model/book_model.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  const BookDetailsPage({
    super.key,
    required this.bookId,
    required this.title,
    this.authors = const <String>[],
    this.pageCount,
    required this.publisher,
    this.publishedDate,
    required this.description,
    required this.imageLink,
    required this.language,
  });

  factory BookDetailsPage.fromModel(BookModel model) {
    return BookDetailsPage(
      bookId: model.id,
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

  final String bookId;
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
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            children: <Widget>[
              Row(
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
                              color: context.colors.boxShadow,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              title.combineTitleWithDate(publishedDate),
                              style: context.textStyles.cardTitleMedium,
                            ),
                          ),
                          if (authors.isNotEmpty)
                            Text(
                              context.l10n.authorsHeader.combineSectionHeaderWith(
                                authors.toFormattedString(),
                              ),
                            ),
                          if (publisher.isNotEmpty)
                            Text(context.l10n.publisherHeader.combineSectionHeaderWith(publisher)),
                          if (pageCount case final int pageCount)
                            Text(context.l10n.pageCountHeader.combineSectionHeaderWith(pageCount)),
                          Text(context.l10n.bookLanguageHeader.combineSectionHeaderWith(language)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Column(
                  children: <Widget>[
                    if (description.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(description),
                      ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FavoriteBookButton(bookId: bookId),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
