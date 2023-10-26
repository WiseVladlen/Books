part of 'user_auth_bloc.dart';

final class UserAuthState extends Equatable {
  const UserAuthState._({
    this.user,
    this.status = AuthenticationStatus.unauthenticated,
  });

  const UserAuthState.unauthenticated() : this._();

  const UserAuthState.authenticated({required UserModel user})
      : this._(
          user: user,
          status: AuthenticationStatus.authenticated,
        );

  final UserModel? user;
  final AuthenticationStatus status;

  @override
  List<Object?> get props => <Object?>[user, status];
}
