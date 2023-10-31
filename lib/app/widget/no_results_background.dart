import 'package:flutter/material.dart';

class NoResultsBackground extends StatelessWidget {
  const NoResultsBackground({
    super.key,
    required this.icon,
    required this.text,
  });

  final Icon icon;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        spacing: 16,
        children: <Widget>[
          icon,
          text,
        ],
      ),
    );
  }
}
