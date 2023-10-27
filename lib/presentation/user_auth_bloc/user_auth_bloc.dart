import 'dart:async';

import 'package:books/data/cache_storage.dart';
import 'package:books/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_auth_event.dart';
part 'user_auth_state.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  UserAuthBloc({required this.authRepository}) : super(_buildState) {
    on<_AuthenticationStatusChanged>(_statusChanged);
    on<LogoutRequested>(_logoutRequested);
    on<SwitchToLoginPage>(_switchToLoginPage);
    on<SwitchToSignUpPage>(_switchToSignUpPage);

    _statusSubscription = authRepository.statusStream.listen((AuthStatus status) {
      add(_AuthenticationStatusChanged(status));
    });
  }

  /// Returns the auth state according to the current authenticated user
  static UserAuthState get _buildState {
    return switch (CacheStorage().readUser()) {
      final UserModel user => UserAuthState.authenticated(user: user),
      (_) => const UserAuthState.unauthenticated(),
    };
  }

  late final StreamSubscription<AuthStatus> _statusSubscription;

  final IAuthRepository authRepository;

  void _statusChanged(_AuthenticationStatusChanged event, Emitter<UserAuthState> emit) {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        emit(const UserAuthState.unauthenticated());
      case AuthStatus.authenticated:
        emit(_buildState);
    }
  }

  void _logoutRequested(LogoutRequested event, Emitter<UserAuthState> emit) {
    authRepository.logOut();
  }

  void _switchToLoginPage(SwitchToLoginPage event, Emitter<UserAuthState> emit) {
    emit(const UserAuthState.unauthenticated());
  }

  void _switchToSignUpPage(SwitchToSignUpPage event, Emitter<UserAuthState> emit) {
    emit(const UserAuthState.unauthenticated(isLoginPage: false));
  }

  @override
  Future<void> close() {
    _statusSubscription.cancel();
    return super.close();
  }
}
