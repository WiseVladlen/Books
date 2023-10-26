part of 'user_auth_bloc.dart';

abstract class UserAuthEvent {
  const UserAuthEvent();
}

final class _AuthenticationStatusChanged extends UserAuthEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;
}

final class LogoutRequested extends UserAuthEvent {
  const LogoutRequested();
}
