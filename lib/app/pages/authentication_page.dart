import 'package:books/app/pages/pages.dart';
import 'package:books/presentation/presentation.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      context.l10n.appName,
                      style: context.textStyles.appTitleLarge,
                    ),
                  ),
                  BlocBuilder<UserAuthBloc, UserAuthState>(
                    buildWhen: (UserAuthState oldState, UserAuthState newState) {
                      return oldState.isLoginPage != newState.isLoginPage;
                    },
                    builder: (BuildContext context, UserAuthState state) {
                      return state.isLoginPage ? const LoginPage() : const SignUpPage();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
