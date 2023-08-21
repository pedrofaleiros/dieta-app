import 'package:flutter/material.dart';
import 'package:macros_app/src/features/home/presentation/view/pages/foods_page.dart';
import 'package:macros_app/src/features/home/presentation/view/widgets/stats_top_widget.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  static const routeName = '/stats';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        shadowColor: Theme.of(context).colorScheme.onBackground,
        elevation: 1,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        title: Text('Estatisticas'),
      ),
      body: Column(
        children: [
          StatsTopWidget(),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, FoodsPage.routeName);
            },
            child: Text('Ver alimentos'),
          ),
        ],
      ),
    );
  }
}
