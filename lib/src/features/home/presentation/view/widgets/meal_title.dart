import 'package:flutter/material.dart';
import 'package:macros_app/src/features/home/presentation/view/widgets/meal_bottom_sheet.dart';
import 'package:macros_app/src/features/home/presentation/view/widgets/trailing_widget.dart';
import 'package:macros_app/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../domain/model/meal_model.dart';

class MealTitle extends StatelessWidget {
  const MealTitle({
    super.key,
    required this.meal,
  });

  final MealModel meal;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                meal.name,
                softWrap: true, // Garante que o texto será quebrado
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          TrailingWidget(meal: meal),
        ],
      ),
    );
  }
}
