enum AuthStatus {
  authenticated,
  unauthenticated;

  bool get isAuthenticated => this == authenticated;
}
