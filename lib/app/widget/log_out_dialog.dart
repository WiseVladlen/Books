import 'package:books/presentation/user_auth_bloc/user_auth_bloc.dart';
import 'package:books/utils/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _LogOutAlertDialog extends StatelessWidget {
  const _LogOutAlertDialog({required this.dialogContext});

  final BuildContext dialogContext;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.logOutQuestion),
      titlePadding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      titleTextStyle: context.textStyles.dialogTitle,
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          style: context.buttonStyles.negativeDialogButton,
          child: Text(context.l10n.negativeDialogButton),
        ),
        TextButton(
          onPressed: () {
            context.read<UserAuthBloc>().add(const LogoutRequested());
            Navigator.of(dialogContext).pop();
          },
          style: context.buttonStyles.positiveDialogButton,
          child: Text(context.l10n.positiveDialogButton),
        ),
      ],
    );
  }
}

Future<void> showLogOutDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) => _LogOutAlertDialog(dialogContext: dialogContext),
  );
}
