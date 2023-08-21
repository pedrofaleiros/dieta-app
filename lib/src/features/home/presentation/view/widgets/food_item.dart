import 'package:flutter/material.dart';
import 'package:macros_app/src/features/home/presentation/view/widgets/meal_widget.dart';
import 'package:macros_app/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../domain/model/item_model.dart';

class FoodItem extends StatelessWidget {
  FoodItem({
    super.key,
    required this.item,
    required this.mealId,
  });

  final ItemModel item;
  final String mealId;

  int kcal = 0;
  int carb = 0;
  int prot = 0;
  int fats = 0;

  void calculateMacros() {
    double dkcal = 0;
    double dcarb = 0;
    double dprot = 0;
    double dfats = 0;

    dkcal += item.food.kcal * item.amount / 100;
    dprot += item.food.prot * item.amount / 100;
    dcarb += item.food.carb * item.amount / 100;
    dfats += item.food.fat * item.amount / 100;

    kcal = dkcal.toInt();
    prot = dprot.toInt();
    carb = dcarb.toInt();
    fats = dfats.toInt();
  }

  @override
  Widget build(BuildContext context) {
    calculateMacros();
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => _confirmDialog(context),
        );
      },
      key: Key(item.id),
      onDismissed: (direction) async {
        await context.read<MealViewmodel>().deleteItem(mealId, item.id);
      },
      direction: DismissDirection.endToStart,
      background: _dismissBackground(context),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding:
                const EdgeInsets.only(left: 8.0, right: 8, top: 0, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.food.name,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  '$kcal Kcal',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 8.0, right: 8, top: 0, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${item.amount} ${item.food.liquid ? 'ml' : 'g'}',
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
                      text: '$carb',
                      label: 'C:',
                      color: Colors.red,
                    ),
                    MacrosText(
                      text: '$prot',
                      label: 'P:',
                      color: const Color(0xff1565C0),
                    ),
                    MacrosText(
                      text: '$fats',
                      label: 'F:',
                      color: Colors.amber,
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 4),
          const MyDivider()
        ],
      ),
    );
  }

  Widget _dismissBackground(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Theme.of(context).colorScheme.error,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.bottomRight,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete),
          ],
        ),
      ),
    );
  }

  AlertDialog _confirmDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.outline,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Remover alimento?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(
                  'Remover',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
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
