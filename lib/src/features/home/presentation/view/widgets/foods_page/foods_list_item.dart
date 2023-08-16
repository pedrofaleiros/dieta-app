import 'package:flutter/material.dart';
import 'package:macros_app/src/features/home/domain/model/food_model.dart';
import 'package:macros_app/src/features/home/presentation/view/widgets/meal_widget.dart';

class FoodListItem extends StatelessWidget {
  FoodListItem({
    super.key,
    required this.food,
  });

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                food.name,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                '${food.kcal} Kcal',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '100 ${food.liquid ? 'ml' : 'g'}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 12,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.75),
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MacrosText(
                    text: '${food.carb}',
                    label: 'C:',
                    color: Colors.red,
                  ),
                  MacrosText(
                    text: '${food.prot}',
                    label: 'P:',
                    color: const Color(0xff1565C0),
                  ),
                  MacrosText(
                    text: '${food.fat}',
                    label: 'F:',
                    color: Colors.amber,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MacrosText extends StatelessWidget {
  const MacrosText({
    super.key,
    required this.text,
    required this.label,
    required this.color,
  });

  final String text;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 15),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
          ),
        ),
        SizedBox(width: 2),
        Text(
          '$text g',
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
