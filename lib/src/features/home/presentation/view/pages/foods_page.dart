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

  Future<void> _addItem(dynamic response, BuildContext context, String mealId,
      FoodModel food) async {
    if (response == null) return;

    if (response) {
      await context
          .read<MealViewmodel>()
          .addFoodToMeal(
            mealId,
            food,
            double.tryParse(amountController.text) ?? 0,
          )
          .then((value) => Navigator.pop(context));
    }
  }

  Future<void> _showDialog(
      BuildContext context, String mealId, FoodModel food) async {
    amountController.clear();
    await showDialog(
      context: context,
      builder: (context) {
        return _amountDialog(
          context,
          mealId,
          food,
        );
      },
    ).then(
      (res) => _addItem(
        res,
        context,
        mealId,
        food,
      ),
    );
  }

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
      appBar: _getAppBar(mealId, context),
      body: FutureBuilder(
        future: controller.getFoods(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _loadingIndicator;
          }

          return Observer(
            builder: (context) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) async {
                      await context.read<FoodsViewmodel>().searchFoods(value);
                    },
                    onEditingComplete:
                        mealId == null && controller.foods.isNotEmpty
                            ? null
                            : () async => _showDialog(
                                  context,
                                  mealId!,
                                  controller.foods[0],
                                ),
                    style: Theme.of(context).textTheme.bodySmall,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Pesquise',
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                if (controller.foods.isEmpty)
                  const Text('Sem resultados')
                else
                  Expanded(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        notification.disallowIndicator();
                        return true;
                      },
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const MyDivider(),
                        itemCount: controller.foods.length,
                        itemBuilder: (context, index) => OutlinedButton(
                          onPressed: mealId == null
                              ? null
                              : () async => _showDialog(
                                    context,
                                    mealId!,
                                    controller.foods[index],
                                  ),
                          child: FoodListItem(
                            food: controller.foods[index],
                          ),
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

  AppBar _getAppBar(String? mealId, BuildContext context) {
    return AppBar(
      backgroundColor: mealId == null
          ? Theme.of(context).colorScheme.background
          : Theme.of(context).colorScheme.primary,
      foregroundColor: mealId == null
          ? Theme.of(context).colorScheme.onBackground
          : Theme.of(context).colorScheme.background,
      title: mealId == null
          ? const Text('Alimentos')
          : const Text('Adicionar alimento'),
    );
  }

  AlertDialog _amountDialog(
      BuildContext context, String? mealId, FoodModel food) {
    final FocusNode focus = FocusNode();

    FocusScope.of(context).requestFocus(focus);

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.outline,
      title: Text(
        food.name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      content: TextField(
        focusNode: focus,
        onEditingComplete: () async {
          if (double.tryParse(amountController.text) == null) {
            Navigator.pop(context, false);
            return;
          }
          Navigator.pop(context, true);
        },
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
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        TextButton(
          onPressed: () async {
            if (double.tryParse(amountController.text) == null) {
              Navigator.pop(context, false);
              return;
            }
            Navigator.pop(context, true);
          },
          child: const Text(
            'ADICIONAR',
          ),
        ),
      ],
    );
  }
}
