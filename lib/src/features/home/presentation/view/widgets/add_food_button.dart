import 'package:flutter/material.dart';

class AddFoodButton extends StatelessWidget {
  const AddFoodButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: () {
          //navigate to add food to meal page
          print('Add food button');
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
