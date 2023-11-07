import 'package:books/domain/model/enum/enum.dart';
import 'package:books/presentation/search_bloc/search_bloc.dart';
import 'package:books/utils/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef _SectionItems<T> = Iterable<({String title, T value})>;

class _SingleSelectSection<T> extends StatelessWidget {
  const _SingleSelectSection({
    required this.title,
    required this.groupValue,
    required this.onChanged,
    required this.items,
  });

  final String title;

  final T groupValue;

  final ValueChanged<T?> onChanged;

  final _SectionItems<T> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 12),
          child: Text(
            title,
            style: context.textStyles.dialogTitle,
            textAlign: TextAlign.center,
          ),
        ),
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

Future<void> showSettingsModalBottomSheet(BuildContext externalContext) {
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _SingleSelectSection<DataSourceType>(
              title: context.l10n.dataSourceTypeHeader,
              groupValue: externalContext.read<SearchBloc>().state.dataSourceType,
              onChanged: (DataSourceType? value) {
                if (value == null) return;

                // Since no bloc is found when using context, externalContext is used
                externalContext.read<SearchBloc>().add(DataSourceChangedEvent(value));
                Navigator.pop(context);
              },
              items: DataSourceType.values.map(
                (DataSourceType dataSourceType) => switch (dataSourceType) {
                  DataSourceType.local => (
                      title: context.l10n.localDataSourceHeader,
                      value: dataSourceType
                    ),
                  DataSourceType.remote => (
                      title: context.l10n.remoteDataSourceHeader,
                      value: dataSourceType
                    ),
                },
              ),
            ),
            const Divider(),
            _SingleSelectSection<LanguageCode>(
              title: externalContext.l10n.languageHeader,
              groupValue: externalContext.read<SearchBloc>().state.languageCode,
              onChanged: (LanguageCode? value) {
                if (value == null) return;

                // Since no bloc is found when using context, externalContext is used
                externalContext.read<SearchBloc>().add(LanguageChangedEvent(value));
                Navigator.pop(context);
              },
              items: LanguageCode.values.map(
                (LanguageCode languageCode) => (
                  title: languageCode.name.toUpperCase(),
                  value: languageCode,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
