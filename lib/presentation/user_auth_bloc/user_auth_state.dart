part of 'user_auth_bloc.dart';

final class UserAuthState extends Equatable {
  const UserAuthState._({
    this.user,
    this.status = AuthStatus.unauthenticated,
    this.isLoginPage = true,
  });

  const UserAuthState.unauthenticated({bool isLoginPage = true}) : this._(isLoginPage: isLoginPage);

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
