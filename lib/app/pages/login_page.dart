import 'package:books/app/widget/widget.dart';
import 'package:books/domain/repository/repository.dart';
import 'package:books/presentation/auth/auth.dart';
import 'package:books/presentation/user_auth_bloc/user_auth_bloc.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => LoginCubit(
        authenticationRepository: context.read<IAuthRepository>(),
      ),
      child: Column(
        children: <Widget>[
          BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (LoginState oldState, LoginState newState) {
              return oldState.email != newState.email;
            },
            builder: (BuildContext context, LoginState state) {
              return OutlinedTextField(
                key: const Key('loginPage_emailInput_textField'),
                keyboardType: TextInputType.emailAddress,
                labelText: context.l10n.emailLabel,
                errorText: state.email.hasError ? context.l10n.invalidEmailMessage : null,
                padding: const EdgeInsets.symmetric(vertical: 8),
                valueChanged: (String value) => context.read<LoginCubit>().emailChanged(value),
              );
            },
          ),
          BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (LoginState oldState, LoginState newState) {
              return oldState.password != newState.password;
            },
            builder: (BuildContext context, LoginState state) {
              return OutlinedTextField(
                key: const Key('loginPage_passwordInput_textField'),
                obscureText: true,
                labelText: context.l10n.passwordLabel,
                errorText: state.password.hasError ? context.l10n.invalidPasswordMessage : null,
                padding: const EdgeInsets.symmetric(vertical: 8),
                valueChanged: (String value) => context.read<LoginCubit>().passwordChanged(value),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (LoginState oldState, LoginState newState) {
                return (oldState.status != newState.status) ||
                    (oldState.isValid != newState.isValid);
              },
              builder: (BuildContext context, LoginState state) {
                return ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.maxFinite),
                  child: FilledButton(
                    onPressed: (state.isValid && !state.status.isInProgress)
                        ? () => context.read<LoginCubit>().logIn()
                        : null,
                    child: state.status.isInProgress
                        ? Transform.scale(scale: 0.5, child: const CircularProgressIndicator())
                        : Text(context.l10n.logInHeader),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (LoginState oldState, LoginState newState) {
                return oldState.status != newState.status;
              },
              builder: (BuildContext context, LoginState state) {
                return TextButton(
                  onPressed: !state.status.isInProgress
                      ? () => context.read<UserAuthBloc>().add(const SwitchToSignUpPage())
                      : null,
                  child: Text(context.l10n.notAccountQuestion),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
