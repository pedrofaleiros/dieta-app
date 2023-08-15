import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodel/meal_viewmodel.dart';

class DeleteMealButton extends StatelessWidget {
  const DeleteMealButton({
    super.key,
    required this.mealId,
  });

  final String mealId;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await context.read<MealViewmodel>().deleteMeal(mealId).then(
              (value) => Navigator.pop(context),
            );
      },
      style: ButtonStyle(
        overlayColor: MaterialStatePropertyAll(
          Theme.of(context).colorScheme.outline,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Apagar',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ],
        ),
      ),
    );
  }
}
