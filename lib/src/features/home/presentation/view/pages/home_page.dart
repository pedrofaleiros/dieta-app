import 'package:flutter/material.dart';
import 'package:macros_app/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:macros_app/src/features/home/presentation/view/pages/meals_page.dart';
import 'package:macros_app/src/features/home/presentation/viewmodel/foods_viewmodel.dart';
import 'package:macros_app/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final mealController = context.read<MealViewmodel>();
      await mealController.setUserToken();

      await mealController.getMeals().then(
        (value) async {
          await context.read<FoodsViewmodel>().setUserToken();
          setState(
            () {
              isLoading = false;
            },
          );
        },
      );
    });
  }

  List<Widget> pages = const [
    Placeholder(),
    MealsPage(),
    Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? _loadingIndicator
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              showUnselectedLabels: false,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Perfil',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.food_bank_outlined,
                    ),
                    label: 'Refeições'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.analytics_outlined,
                    ),
                    label: 'Dados'),
              ],
              currentIndex: _selectedIndex,
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
            ),
            body: pages[_selectedIndex],
          );
  }
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
        // onPressed: () => context.read<AuthViewModel>().logout(),
        onPressed: () {},
        icon: const Icon(Icons.logout),
      ),
    ],
  );
}

Widget get _loadingIndicator => const Center(
      child: CircularProgressIndicator(),
    );
