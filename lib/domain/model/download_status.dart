enum DownloadStatus {
  initial,
  inProgress,
  success,
  failure;

  bool get isInitial => this == initial;
  bool get isInProgress => this == inProgress;
  bool get isSuccess => this == success;
  bool get isFailure => this == failure;
}