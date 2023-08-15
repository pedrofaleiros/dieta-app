import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macros_app/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

import 'meal_widget.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.read<MealViewmodel>();

    return Observer(
      builder: (_) => ListView.builder(
        itemCount: controller.meals.length,
        itemBuilder: (context, index) {
          return MealWidget(meal: controller.meals[index]);
        },
      ),
    );
  }
}
