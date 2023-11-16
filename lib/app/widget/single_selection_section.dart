import 'package:flutter/material.dart';

typedef SectionItems<T> = Iterable<({String title, T value})>;

class SingleSelectSection<T> extends StatelessWidget {
  const SingleSelectSection({
    required this.groupValue,
    required this.onChanged,
    required this.items,
  });

  final T groupValue;
  final SectionItems<T> items;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (final ({String title, T value}) item in items)
          RadioListTile<T>(
            value: item.value,
            groupValue: groupValue,
            onChanged: onChanged,
            title: Text(item.title),
          ),
      ],
    );
  }
}
