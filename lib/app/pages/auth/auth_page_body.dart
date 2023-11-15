import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';

class AuthPageBody extends StatelessWidget {
  const AuthPageBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 16),
                child: Text(
                  context.l10n.appName,
                  style: context.textStyles.appTitleLarge,
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
