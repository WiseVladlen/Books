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
  }) : super(const UserAuthState.initial()) {
    on<_AuthenticationStatusChanged>(_statusChanged);
    on<UserLoadingEvent>(_userLoading);
    on<LogoutRequested>(_logoutRequested);
    on<SwitchToLoginPage>(_switchToLoginPage);
    on<SwitchToSignUpPage>(_switchToSignUpPage);

    add(const UserLoadingEvent());

    _statusSubscription = authRepository.statusStream.listen((AuthStatus status) {
      add(_AuthenticationStatusChanged(status));
    });
  }

  late final StreamSubscription<AuthStatus> _statusSubscription;

  final IAuthRepository authRepository;
  final IUserRepository userRepository;

  Future<UserAuthState> _buildState() async {
    return switch (await userRepository.fetchAuthenticatedUser()) {
      final UserModel user => UserAuthState.authenticated(user: user),
      (_) => const UserAuthState.unauthenticated(),
    };
  }

  Future<void> _statusChanged(
    _AuthenticationStatusChanged event,
    Emitter<UserAuthState> emit,
  ) async {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        emit(const UserAuthState.unauthenticated());
      case AuthStatus.authenticated:
        emit(await _buildState());
      case AuthStatus.initial:
        emit(const UserAuthState.initial());
    }
  }

  Future<void> _userLoading(UserLoadingEvent event, Emitter<UserAuthState> emit) => _buildState();

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
