import 'dart:async';

import 'package:books/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_auth_event.dart';
part 'user_auth_state.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  UserAuthBloc({
    required this.authRepository,
    required this.userRepository,
  }) : super(_buildStateByUser(userRepository.authenticatedUserOrNull)) {
    on<_AuthenticationStatusChanged>(_statusChanged);
    on<LogoutRequested>(_logoutRequested);

    _statusSubscription = authRepository.statusStream.listen((AuthStatus status) {
      add(_AuthenticationStatusChanged(status));
    });
  }

  late final StreamSubscription<AuthStatus> _statusSubscription;

  final IAuthRepository authRepository;
  final IUserRepository userRepository;

  static UserAuthState _buildStateByUser(UserModel? user) {
    return user != null
        ? UserAuthState.authenticated(user: user)
        : const UserAuthState.unauthenticated();
  }

  Future<void> _statusChanged(
    _AuthenticationStatusChanged event,
    Emitter<UserAuthState> emit,
  ) async {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        emit(const UserAuthState.unauthenticated());
      case AuthStatus.authenticated:
        emit(_buildStateByUser(userRepository.authenticatedUserOrNull));
    }
  }

  void _logoutRequested(LogoutRequested event, Emitter<UserAuthState> emit) {
    authRepository.logOut();
  }

  @override
  Future<void> close() {
    _statusSubscription.cancel();
    return super.close();
  }
}
