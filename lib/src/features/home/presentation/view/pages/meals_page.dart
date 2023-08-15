import 'package:flutter/material.dart';
import 'package:macros_app/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:macros_app/src/features/home/presentation/view/pages/create_meal_page.dart';
import 'package:macros_app/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

import '../widgets/home_page_content.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({super.key});

  static const routeName = '/meals';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, CreateMealPage.routeName);
      //   },
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   child: Icon(
      //     Icons.add,
      //     color: Theme.of(context).colorScheme.background,
      //   ),
      // ),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: getHomeAppBar(context),
      body: const HomePageContent(),
    );
  }

  AppBar getHomeAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      shadowColor: Theme.of(context).colorScheme.onBackground,
      elevation: 1,
      foregroundColor: Theme.of(context).colorScheme.onBackground,
      title: Text(
        context.read<AuthViewModel>().sessionUser!.name,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      actions: [
        IconButton(
          tooltip: 'Adicionar refeição',
          // onPressed: () => context.read<AuthViewModel>().logout(),
          onPressed: () {
            Navigator.pushNamed(context, CreateMealPage.routeName);
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
