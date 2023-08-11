import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macros_app/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthViewModel>();

    return Observer(
      builder: (_) => TextField(
        onChanged: (value) {
          auth.authUser = auth.authUser.copyWith(email: value);
        },
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          labelText: 'Email',
          errorText: auth.errors.email,
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
