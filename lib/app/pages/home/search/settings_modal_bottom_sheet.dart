import 'package:books/app/widget/rounded_rectangle_border_bottom_sheet.dart';
import 'package:books/domain/model/enum/enum.dart';
import 'package:books/presentation/search_bloc/search_bloc.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef _SectionItems<T> = Iterable<({String title, T value})>;

class _SingleSelectSection<T> extends StatelessWidget {
  const _SingleSelectSection({
    required this.groupValue,
    required this.onChanged,
    required this.items,
  });

  final T groupValue;

  final ValueChanged<T?> onChanged;

  final _SectionItems<T> items;

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

class _TrailingTileParameter extends StatelessWidget {
  const _TrailingTileParameter({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(value, style: context.textStyles.trailingTileText),
        const Icon(Icons.keyboard_arrow_right),
      ],
    );
  }
}

Future<void> showSearchSettingsModalBottomSheet(BuildContext externalContext) {
  return showRoundedRectangleBorderModalBottomSheet(
    externalContext,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.data_object),
          title: Text(externalContext.l10n.dataSourceTypeHeader),
          trailing: _TrailingTileParameter(
            value: externalContext.read<SearchBloc>().state.dataSourceType.name.toCapitalized(),
          ),
          onTap: () {
            Navigator.pop(externalContext);
            showDataSourceSettingsModalBottomSheet(externalContext);
          },
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(externalContext.l10n.bookLanguageHeader),
          trailing: _TrailingTileParameter(
            value: externalContext.read<SearchBloc>().state.languageCode.name.toUpperCase(),
          ),
          onTap: () {
            Navigator.pop(externalContext);
            showBookLanguageSettingsModalBottomSheet(externalContext);
          },
        ),
      ],
    ),
  );
}

Future<void> showDataSourceSettingsModalBottomSheet(BuildContext context) {
  return showRoundedRectangleBorderModalBottomSheet(
    context,
    child: _SingleSelectSection<DataSourceType>(
      groupValue: context.read<SearchBloc>().state.dataSourceType,
      onChanged: (DataSourceType? value) {
        if (value == null) return;

        context.read<SearchBloc>().add(DataSourceChangedEvent(value));
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
  );
}

Future<void> showBookLanguageSettingsModalBottomSheet(BuildContext context) {
  return showRoundedRectangleBorderModalBottomSheet(
    context,
    child: _SingleSelectSection<LanguageCode>(
      groupValue: context.read<SearchBloc>().state.languageCode,
      onChanged: (LanguageCode? value) {
        if (value == null) return;

        context.read<SearchBloc>().add(LanguageChangedEvent(value));
        Navigator.pop(context);
      },
      items: LanguageCode.values.map(
        (LanguageCode languageCode) => (
          title: languageCode.name.toUpperCase(),
          value: languageCode,
        ),
      ),
    ),
  );
}