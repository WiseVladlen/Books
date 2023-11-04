enum ConnectionStatus {
  online,
  offline,
  other;

  bool get isOnline => this == online;
  bool get isOffline => this == offline;
}
