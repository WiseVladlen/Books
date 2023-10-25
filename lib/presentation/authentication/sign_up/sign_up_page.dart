import 'package:books/domain/domain.dart';
import 'package:books/presentation/authentication/authentication.dart';
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
        authenticationRepository: context.read<IAuthenticationRepository>(),
      ),
      child: const Wrap(
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: <Widget>[
          _NameInput(),
          _EmailInput(),
          _PasswordInput(),
          _SignUpButton(),
          _LogInButton(),
        ],
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState oldState, SignUpState newState) => oldState.name != newState.name,
      builder: (BuildContext context, SignUpState state) {
        return TextField(
          key: const Key('signUpPage_nameInput_textField'),
          onChanged: (String name) => context.read<SignUpCubit>().nameChanged(name),
          decoration: FormInputDecoration.from(
            labelText: context.l10n.nameLabel,
            errorText: state.name.hasError ? context.l10n.invalidNameMessage : null,
          ),
          cursorColor: Colors.green,
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState oldState, SignUpState newState) => oldState.email != newState.email,
      builder: (BuildContext context, SignUpState state) {
        return TextField(
          key: const Key('signUpPage_emailInput_textField'),
          onChanged: (String email) => context.read<SignUpCubit>().emailChanged(email),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState oldState, SignUpState newState) {
        return oldState.password != newState.password;
      },
      builder: (BuildContext context, SignUpState state) {
        return TextField(
          key: const Key('signUpPage_passwordInput_textField'),
          onChanged: (String password) => context.read<SignUpCubit>().passwordChanged(password),
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

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState oldState, SignUpState newState) {
        return (oldState.status != newState.status) || (oldState.isValid != newState.isValid);
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
    );
  }
}

class _LogInButton extends StatelessWidget {
  const _LogInButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState oldState, SignUpState newState) {
        return oldState.status != newState.status;
      },
      builder: (BuildContext context, SignUpState state) {
        return TextButton(
          onPressed: !state.status.isInProgress
              ? () => context.read<AuthenticationPageModel>().onNavigateToLoginPage()
              : null,
          child: Text(context.l10n.alreadyHaveAccountQuestion),
        );
      },
    );
  }
}
