import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macros_app/src/features/home/domain/model/item_model.dart';
import 'package:macros_app/src/features/home/presentation/view/widgets/foods_page/foods_list_item.dart';
import 'package:macros_app/src/features/home/presentation/view/widgets/meal_widget.dart';
import 'package:macros_app/src/features/home/presentation/viewmodel/foods_viewmodel.dart';
import 'package:macros_app/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

import '../widgets/foods_page/search_text_field.dart';

class FoodsPage extends StatelessWidget {
  const FoodsPage({super.key});

  static const routeName = '/foods';

  Widget get _loadingIndicator =>
      const Center(child: CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    final response = ModalRoute.of(context)!.settings.arguments;

    String? mealId;
    if (response == null) {
      mealId = null;
    } else {
      mealId = response as String;
    }

    final controller = context.read<FoodsViewmodel>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.background,
        title:
            mealId == null ? const Text('Alimentos') : const Text('Adicionar alimento'),
      ),
      body: FutureBuilder(
        future: controller.getFoods(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _loadingIndicator;
          }

          return Observer(
            builder: (context) => Column(
              children: [
                const SearchTextField(),
                controller.foods.isEmpty
                    ? const Text('Sem resultados')
                    : Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: controller.foods.length,
                          itemBuilder: (context, index) =>
                              FoodListItem(food: controller.foods[index]),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
