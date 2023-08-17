import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macros_app/src/features/home/domain/model/item_model.dart';
import 'package:macros_app/src/features/home/presentation/view/widgets/add_food_button.dart';
import 'package:macros_app/src/features/home/presentation/view/widgets/macros_count_widget.dart';

import '../../../domain/model/meal_model.dart';
import 'food_item.dart';
import 'meal_title.dart';

class MealWidget extends StatelessWidget {
  const MealWidget({
    super.key,
    required this.meal,
  });

  final MealModel meal;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MealTitle(meal: meal),
          for (var item in meal.items) FoodItem(item: item, mealId: meal.id),
          // const MyDivider(),
          AddFoodButton(mealId: meal.id),
          const MyDivider(),
          MacrosCountWidget(meal: meal),
          const MyDivider(),
        ],
      ),
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 0.5,
      color: Theme.of(context).colorScheme.outline,
    );
  }
}
