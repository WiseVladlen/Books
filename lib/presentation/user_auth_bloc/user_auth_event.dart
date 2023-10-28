part of 'user_auth_bloc.dart';

abstract class UserAuthEvent {
  const UserAuthEvent();
}

final class _AuthenticationStatusChanged extends UserAuthEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthStatus status;
}

final class LogoutRequested extends UserAuthEvent {
  const LogoutRequested();
}

final class SwitchToLoginPage extends UserAuthEvent {
  const SwitchToLoginPage();
}

final class SwitchToSignUpPage extends UserAuthEvent {
  const SwitchToSignUpPage();
}
