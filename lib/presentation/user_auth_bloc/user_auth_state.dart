part of 'user_auth_bloc.dart';

final class UserAuthState extends Equatable {
  const UserAuthState._({
    this.user,
    this.status = AuthStatus.initial,
    this.isLoginPage = true,
  });

  const UserAuthState.initial() : this._();

  const UserAuthState.unauthenticated({bool isLoginPage = true})
      : this._(
          status: AuthStatus.unauthenticated,
          isLoginPage: isLoginPage,
        );

  const UserAuthState.authenticated({required UserModel user})
      : this._(
          user: user,
          status: AuthStatus.authenticated,
        );

  final UserModel? user;
  final AuthStatus status;
  final bool isLoginPage;

  @override
  List<Object?> get props => <Object?>[user, status, isLoginPage];
}
