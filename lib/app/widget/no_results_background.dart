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
  Widget build(_) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: icon,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: text,
          ),
        ],
      ),
    );
  }
}
