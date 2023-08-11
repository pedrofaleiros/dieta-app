import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/auth_viewmodel.dart';

class LoginErrorWidget extends StatelessWidget {
  const LoginErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthViewModel>();
    return Observer(
      builder: (_) => auth.errors.loginError != null
          ? Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
                auth.errors.loginError!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
          )
          : Container(),
    );
  }
}
