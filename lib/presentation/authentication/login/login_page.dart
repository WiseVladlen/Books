import 'package:books/domain/repository/repository.dart';
import 'package:books/presentation/authentication/authentication.dart';
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
        authenticationRepository: context.read<IAuthenticationRepository>(),
      ),
      child: const Wrap(
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: <Widget>[
          _EmailInput(),
          _PasswordInput(),
          _LogInButton(),
          _SignUpButton(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (LoginState oldState, LoginState newState) => oldState.email != newState.email,
      builder: (BuildContext context, LoginState state) {
        return TextField(
          key: const Key('loginPage_emailInput_textField'),
          onChanged: (String email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: FormInputDecoration.from(
            labelText: context.l10n.emailLabel,
            errorText: state.email.hasError ? context.l10n.invalidEmailMessage : null,
          ),
          cursorColor: Colors.green,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (LoginState oldState, LoginState newState) {
        return oldState.password != newState.password;
      },
      builder: (BuildContext context, LoginState state) {
        return TextField(
          key: const Key('loginPage_passwordInput_textField'),
          onChanged: (String password) => context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          decoration: FormInputDecoration.from(
            labelText: context.l10n.passwordLabel,
            errorText: state.password.hasError ? context.l10n.invalidPasswordMessage : null,
          ),
          cursorColor: Colors.green,
        );
      },
    );
  }
}

class _LogInButton extends StatelessWidget {
  const _LogInButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (LoginState oldState, LoginState newState) {
        return (oldState.status != newState.status) || (oldState.isValid != newState.isValid);
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
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (LoginState oldState, LoginState newState) => oldState.status != newState.status,
      builder: (BuildContext context, LoginState state) {
        return TextButton(
          onPressed: !state.status.isInProgress
              ? () => context.read<AuthenticationPageModel>().onNavigateToSignUpPage()
              : null,
          child: Text(context.l10n.notAccountQuestion),
        );
      },
    );
  }
}
