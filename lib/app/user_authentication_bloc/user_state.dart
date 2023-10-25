import 'package:books/domain/model/model.dart';
import 'package:equatable/equatable.dart';

final class UserAuthState extends Equatable {
  const UserAuthState._({
    this.user = UserModel.proxy,
    this.status = AuthenticationStatus.unauthenticated,
  });

  const UserAuthState.unauthenticated() : this._();

  const UserAuthState.authenticated({required UserModel user})
      : this._(
          user: user,
          status: AuthenticationStatus.authenticated,
        );

  final UserModel user;
  final AuthenticationStatus status;

  @override
  List<Object> get props => <Object>[user, status];
}
