import 'package:books/utils/build_context.dart';
import 'package:flutter/material.dart';

class _InformationAlertDialog extends StatelessWidget {
  const _InformationAlertDialog({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      titlePadding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      titleTextStyle: context.textStyles.dialogTitle,
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: context.buttonStyles.positiveDialogButton,
          child: Text(context.l10n.positiveDialogButton),
        ),
      ],
    );
  }
}

Future<void> showInformationDialog(BuildContext context, {required String title}) {
  return showDialog(
    context: context,
    builder: (_) => _InformationAlertDialog(title: title),
  );
}
