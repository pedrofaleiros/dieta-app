import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/auth_viewmodel.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthViewModel>();

    return Observer(
      builder: (_) => TextField(
        onChanged: (value) {
          auth.authUser = auth.authUser.copyWith(name: value);
        },
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          labelText: 'Username',
          errorText: auth.errors.name,
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
