import 'dart:async';

import 'package:books/app/user_authentication_bloc/user_authentication_bloc.dart';
import 'package:books/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  UserAuthBloc({required this.authRepository}) : super(const UserAuthState.unauthenticated()) {
    on<_AuthenticationStatusChanged>(_statusChanged);
    on<LogoutRequested>(_logoutRequested);

    _statusSubscription = authRepository.statusStream.listen((AuthenticationStatus status) {
      add(_AuthenticationStatusChanged(status));
    });
  }

  late final StreamSubscription<AuthenticationStatus> _statusSubscription;

  final IAuthenticationRepository authRepository;

  void _statusChanged(_AuthenticationStatusChanged event, Emitter<UserAuthState> emit) {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        emit(const UserAuthState.unauthenticated());
      case AuthenticationStatus.authenticated:
        emit(const UserAuthState.authenticated(user: UserModel.proxy));
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
