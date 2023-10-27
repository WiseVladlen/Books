import 'package:books/app/widget/widget.dart';
import 'package:books/domain/domain.dart';
import 'package:books/presentation/auth/auth.dart';
import 'package:books/presentation/user_auth_bloc/user_auth_bloc.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (_) => SignUpCubit(
        authenticationRepository: context.read<IAuthRepository>(),
      ),
      child: Column(
        children: <Widget>[
          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState oldState, SignUpState newState) {
              return oldState.name != newState.name;
            },
            builder: (BuildContext context, SignUpState state) {
              return OutlinedTextField(
                key: const Key('signUpPage_nameInput_textField'),
                labelText: context.l10n.nameLabel,
                errorText: state.name.hasError ? context.l10n.invalidNameMessage : null,
                padding: const EdgeInsets.symmetric(vertical: 8),
                valueChanged: (String value) => context.read<SignUpCubit>().nameChanged(value),
              );
            },
          ),
          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState oldState, SignUpState newState) {
              return oldState.email != newState.email;
            },
            builder: (BuildContext context, SignUpState state) {
              return OutlinedTextField(
                key: const Key('signUpPage_emailInput_textField'),
                keyboardType: TextInputType.emailAddress,
                labelText: context.l10n.emailLabel,
                errorText: state.email.hasError ? context.l10n.invalidEmailMessage : null,
                padding: const EdgeInsets.symmetric(vertical: 8),
                valueChanged: (String value) => context.read<SignUpCubit>().emailChanged(value),
              );
            },
          ),
          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState oldState, SignUpState newState) {
              return oldState.password != newState.password;
            },
            builder: (BuildContext context, SignUpState state) {
              return OutlinedTextField(
                key: const Key('signUpPage_passwordInput_textField'),
                obscureText: true,
                labelText: context.l10n.passwordLabel,
                errorText: state.password.hasError ? context.l10n.invalidPasswordMessage : null,
                padding: const EdgeInsets.symmetric(vertical: 8),
                valueChanged: (String value) => context.read<SignUpCubit>().passwordChanged(value),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (SignUpState oldState, SignUpState newState) {
                return (oldState.status != newState.status) ||
                    (oldState.isValid != newState.isValid);
              },
              builder: (BuildContext context, SignUpState state) {
                return ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.maxFinite),
                  child: FilledButton(
                    onPressed: (state.isValid && !state.status.isInProgress)
                        ? () => context.read<SignUpCubit>().signUp()
                        : null,
                    child: state.status.isInProgress
                        ? Transform.scale(scale: 0.5, child: const CircularProgressIndicator())
                        : Text(context.l10n.signUpHeader),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (SignUpState oldState, SignUpState newState) {
                return oldState.status != newState.status;
              },
              builder: (BuildContext context, SignUpState state) {
                return TextButton(
                  onPressed: !state.status.isInProgress
                      ? () => context.read<UserAuthBloc>().add(const SwitchToLoginPage())
                      : null,
                  child: Text(context.l10n.alreadyHaveAccountQuestion),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
