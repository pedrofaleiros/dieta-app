import 'package:flutter/material.dart';
import 'package:macros_app/src/features/home/domain/model/meal_model.dart';
import 'package:macros_app/src/features/home/presentation/view/widgets/meal_widget.dart';
import 'bottom_sheet/bottom_widget.dart';
import 'bottom_sheet/delete_meal_button.dart';
import 'bottom_sheet/top_widget.dart';

class MealBottomSheet extends StatelessWidget {
  const MealBottomSheet({
    super.key,
    required this.meal,
  });

  final MealModel meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const TopWidget(),
        const SizedBox(height: 20),
        Text(
          meal.name,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        DeleteMealButton(mealId: meal.id),
        const SizedBox(height: 5),
        const MyDivider(),
        const BottomWidget(),
      ],
    );
  }
}
