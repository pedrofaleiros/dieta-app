import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macros_app/src/features/home/domain/model/food_model.dart';
import 'package:macros_app/src/features/home/domain/model/item_model.dart';
import 'package:macros_app/src/features/home/presentation/view/pages/home_page.dart';
import 'package:macros_app/src/features/home/presentation/view/widgets/foods_page/foods_list_item.dart';
import 'package:macros_app/src/features/home/presentation/view/widgets/meal_widget.dart';
import 'package:macros_app/src/features/home/presentation/viewmodel/foods_viewmodel.dart';
import 'package:macros_app/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

import '../widgets/foods_page/search_text_field.dart';

class FoodsPage extends StatelessWidget {
  FoodsPage({super.key});

  static const routeName = '/foods';

  Widget get _loadingIndicator =>
      const Center(child: CircularProgressIndicator());

  TextEditingController amountController = TextEditingController();

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          //add food
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: mealId == null
            ? Theme.of(context).colorScheme.background
            : Theme.of(context).colorScheme.primary,
        foregroundColor: mealId == null
            ? Theme.of(context).colorScheme.onBackground
            : Theme.of(context).colorScheme.background,
        title: mealId == null
            ? const Text('Alimentos')
            : const Text('Adicionar alimento'),
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
                          separatorBuilder: (context, index) =>
                              const MyDivider(),
                          itemCount: controller.foods.length,
                          itemBuilder: (context, index) => OutlinedButton(
                            onPressed: mealId == null
                                ? null
                                : () {
                                    amountController.clear();
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return _amountDialog(
                                          context,
                                          mealId,
                                          controller.foods[index],
                                        );
                                      },
                                    );
                                  },
                            child: FoodListItem(
                              food: controller.foods[index],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  AlertDialog _amountDialog(
      BuildContext context, String? mealId, FoodModel food) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.outline,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              food.name,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            keyboardType: TextInputType.number,
            style: Theme.of(context).textTheme.bodySmall,
            controller: amountController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Quantidade',
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
              onPressed: () async {
                if (double.tryParse(amountController.text) == null) {
                  return;
                }
                double amount = double.parse(amountController.text);
                await context
                    .read<MealViewmodel>()
                    .addFoodToMeal(
                      mealId!,
                      food,
                      amount,
                    )
                    .then(
                      (value) => Navigator.pushNamedAndRemoveUntil(
                        context,
                        HomePage.routeName,
                        (Route<dynamic> route) => false,
                      ),
                    );
              },
              child: Text(
                'Adicionar',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
