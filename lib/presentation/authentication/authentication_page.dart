import 'package:books/presentation/authentication/authentication.dart';
import 'package:books/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                  ChangeNotifierProvider<AuthenticationPageModel>(
                    create: (_) => AuthenticationPageModel(),
                    child: Builder(
                      builder: (BuildContext context) =>
                          context.watch<AuthenticationPageModel>().isLoginPage
                              ? const LoginPage()
                              : const SignUpPage(),
                    ),
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
