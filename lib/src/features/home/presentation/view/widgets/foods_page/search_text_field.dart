import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodel/foods_viewmodel.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) async {
          await context.read<FoodsViewmodel>().searchFoods(value);
        },
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration(
            filled: true,
            labelText: 'Pesquise',
            fillColor: Theme.of(context).colorScheme.surface,
            border: OutlineInputBorder()),
      ),
    );
  }
}
