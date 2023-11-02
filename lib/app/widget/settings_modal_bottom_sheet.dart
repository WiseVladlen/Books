import 'package:books/domain/model/enum/enum.dart';
import 'package:books/presentation/search_bloc/search_bloc.dart';
import 'package:books/utils/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showSettingsModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(12),
        right: Radius.circular(12),
      ),
    ),
    builder: (BuildContext sheetContext) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _DialogTitle(title: context.l10n.dataSourceTypeHeader),
            RadioListTile<DataSourceType>(
              value: DataSourceType.local,
              groupValue: context.read<SearchBloc>().state.dataSourceType,
              onChanged: (DataSourceType? value) {
                context.read<SearchBloc>().add(DataSourceChangedEvent(value));
                Navigator.pop(context);
              },
              title: Text(context.l10n.localDataSourceHeader),
            ),
            RadioListTile<DataSourceType>(
              value: DataSourceType.remote,
              groupValue: context.read<SearchBloc>().state.dataSourceType,
              onChanged: (DataSourceType? value) {
                context.read<SearchBloc>().add(DataSourceChangedEvent(value));
                Navigator.pop(context);
              },
              title: Text(context.l10n.remoteDataSourceHeader),
            ),
            const Divider(),
            _DialogTitle(title: context.l10n.languageHeader),
            for (final LanguageCode languageCode in LanguageCode.values)
              RadioListTile<LanguageCode>(
                value: languageCode,
                groupValue: context.read<SearchBloc>().state.languageCode,
                onChanged: (_) {
                  context.read<SearchBloc>().add(LanguageChangedEvent(languageCode));
                  Navigator.pop(context);
                },
                title: Text(languageCode.name.toUpperCase()),
              ),
          ],
        ),
      );
    },
  );
}

class _DialogTitle extends StatelessWidget {
  const _DialogTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 12),
      child: SizedBox(
        width: double.maxFinite,
        child: Center(
          child: Text(
            title,
            style: context.textStyles.dialogTitle,
          ),
        ),
      ),
    );
  }
}