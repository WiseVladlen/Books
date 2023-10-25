enum AuthenticationStatus {
  authenticated,
  unauthenticated;

  bool get isAuthenticated => this == authenticated;
}
