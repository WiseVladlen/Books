import 'package:flutter/material.dart';

Future<void> showRoundedRectangleBorderModalBottomSheet(
  BuildContext externalContext, {
  required Widget child,
}) {
  return showModalBottomSheet(
    context: externalContext,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: child,
      );
    },
  );
}
