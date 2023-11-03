enum DataSourceType {
  local,
  remote;

  bool get isLocal => this == local;
  bool get isRemote => this == remote;
}
