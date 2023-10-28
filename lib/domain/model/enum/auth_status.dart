enum AuthStatus {
  initial,
  authenticated,
  unauthenticated;

  bool get isInitial => this == initial;
  bool get isAuthenticated => this == authenticated;
}
