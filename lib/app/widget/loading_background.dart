import 'package:flutter/material.dart';

class LoadingBackground extends StatelessWidget {
  const LoadingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
