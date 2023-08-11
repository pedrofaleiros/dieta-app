import 'package:flutter/material.dart';
import 'package:macros_app/src/features/auth/presentation/view/widgets/name_textfield.dart';
import 'package:macros_app/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';

import '../widgets/login_button.dart';
import '../widgets/password_textfield.dart';
import '../widgets/email_textfield.dart';
import '../widgets/login_error.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginText(),
            NameTextField(),
            SizedBox(height: 15),
            PasswordTextField(),
            SizedBox(height: 15),
            LoginButton(),
            LoginErrorWidget()
          ],
        ),
      ),
    );
  }
}

class LoginText extends StatelessWidget {
  const LoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Text(
        'Insira seus dados',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
    );
  }
}
