import 'package:books/app/app.dart';
import 'package:books/domain/model/model.dart';
import 'package:books/presentation/navigation_bloc/navigation_bloc.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookTile extends StatelessWidget {
  const BookTile({
    super.key,
    required this.book,
    required this.title,
    this.publishedDate,
    required this.description,
    required this.imageLink,
  });

  factory BookTile.fromModel({
    required Key key,
    required BookModel model,
  }) {
    return BookTile(
      key: key,
      book: model,
      title: model.title,
      publishedDate: model.publishedDate,
      description: model.description,
      imageLink: model.imageLink,
    );
  }

  final BookModel book;
  final String title;
  final DateTime? publishedDate;
  final String description;
  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<NavigationBloc>().add(
              AddToRootStackEvent(route: BookDetailsPageRoute(book: book)),
            );
      },
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            title.combineTitleWithDate(publishedDate),
                            style: context.textStyles.cardTitleMedium,
                          ),
                        ),
                        if (description.isNotEmpty)
                          Text(
                            description,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Align(
                alignment: Alignment.centerRight,
                child: FavoriteBookButton(bookId: book.id),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
