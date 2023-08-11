import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/auth_viewmodel.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ElevatedButton(
        style: const ButtonStyle(
          overlayColor: MaterialStatePropertyAll(
            Color(0xff12e8a2),
          ),
        ),
        onPressed: () async => await context.read<AuthViewModel>().login(),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: context.read<AuthViewModel>().isLoading
                  ? SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.background,
                      ),
                    )
                  : Text(
                      'Login',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
