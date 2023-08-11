import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macros_app/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

import 'visibility_button.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool hideText = true;

  void changeVisibility() {
    setState(() {
      hideText = !hideText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthViewModel>();

    return Observer(
      builder: (_) => TextField(
        onChanged: (value) {
          auth.authUser = auth.authUser.copyWith(password: value);
        },
        onEditingComplete: () async => auth.login(),
        obscureText: hideText,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          suffixIcon: VisibilityButton(
            hideText: hideText,
            onPress: changeVisibility,
          ),
          labelText: 'Password',
          errorText: auth.errors.password,
          suffixIconColor: Theme.of(context).colorScheme.outline,
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
