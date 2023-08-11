import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macros_app/src/features/auth/presentation/view/pages/auth_page.dart';
import 'package:macros_app/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:macros_app/src/features/home/presentation/view/pages/home_page.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const routeName = '/';

  Widget get _loadingIndicator =>
      const Center(child: CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthViewModel>();

    return FutureBuilder(
      future: auth.autoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _loadingIndicator;
        }

        return Observer(
          builder: (_) {
            if (auth.isAuthenticated) {
              return const HomePage();
            } else {
              return const AuthPage();
            }
          },
        );
      },
    );
  }
}
