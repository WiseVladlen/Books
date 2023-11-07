import 'package:books/domain/model/enum/enum.dart';

enum ConnectionStatus {
  online,
  offline,
  other;

  bool get isOnline => this == online;
}

extension ConnectionStatusX on ConnectionStatus {
  DataSourceType toDataSourceType() => switch (isOnline) {
        true => DataSourceType.remote,
        false => DataSourceType.local,
      };
}
