import 'dart:async';

import 'package:books/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_auth_event.dart';
part 'user_auth_state.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  UserAuthBloc({required this.authRepository}) : super(const UserAuthState.unauthenticated()) {
    on<_AuthenticationStatusChanged>(_statusChanged);
    on<LogoutRequested>(_logoutRequested);
    on<SwitchToLoginPage>(_switchToLoginPage);
    on<SwitchToSignUpPage>(_switchToSignUpPage);

    _statusSubscription = authRepository.statusStream.listen((AuthStatus status) {
      add(_AuthenticationStatusChanged(status));
    });
  }

  late final StreamSubscription<AuthStatus> _statusSubscription;

  final IAuthRepository authRepository;

  void _statusChanged(_AuthenticationStatusChanged event, Emitter<UserAuthState> emit) {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        emit(const UserAuthState.unauthenticated());
      case AuthStatus.authenticated:
        emit(
          const UserAuthState.authenticated(
            // TODO
            user: UserModel(id: 0, email: 'email', name: 'name'),
          ),
        );
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

  void _switchToLoginPage(SwitchToLoginPage event, Emitter<UserAuthState> emit) {
    emit(const UserAuthState.unauthenticated());
  }

  void _switchToSignUpPage(SwitchToSignUpPage event, Emitter<UserAuthState> emit) {
    emit(const UserAuthState.unauthenticated(isLoginPage: false));
  }
}
