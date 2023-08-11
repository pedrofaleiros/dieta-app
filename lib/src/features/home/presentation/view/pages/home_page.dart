import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macros_app/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthViewModel>();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        title: Text(context.read<AuthViewModel>().authUser.name),
        actions: [
          IconButton(
            onPressed: () => context.read<AuthViewModel>().logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Observer(
          builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ID: ${auth.sessionUser!.id}'),
              Text('Name: ${auth.sessionUser!.name}'),
              Text('Email: ${auth.sessionUser!.email}'),
              // Text('Token: ${auth.sessionUser!.token}'),
            ],
          ),
        ),
      ),
    );
  }
}
