import 'package:flutter/material.dart';
import 'package:macros_app/src/features/home/presentation/view/pages/foods_page.dart';

class AddFoodButton extends StatelessWidget {
  const AddFoodButton({
    super.key,
    required this.mealId,
  });

  final String mealId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: () async {
          //navigate to add food to meal page
          Navigator.pushNamed(
            context,
            FoodsPage.routeName,
            arguments: mealId,
          );
        },
        label: const Text(
          'Adicionar alimento',
          style: TextStyle(fontSize: 12),
        ),
        icon: CircleAvatar(
          radius: 8,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.add,
            size: 14,
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
    );
  }
}
