import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macros_app/src/features/home/domain/model/meal_model.dart';
import 'package:macros_app/src/features/home/presentation/view/widgets/stats_top_widget.dart';
import 'package:macros_app/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

import 'meal_widget.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.read<MealViewmodel>();

    return Column(
      children: [
        Expanded(
          child: Observer(
            builder: (_) =>
                NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: ListView.builder(
                itemCount: controller.meals.length,
                itemBuilder: (context, index) {
                  return
                      // index == 0
                      //     ? Column(
                      //       children: [
                      //         StatsTopWidget(),
                      //         MealWidget(meal: controller.meals[index]),
                      //       ],
                      //     ):
                      index == controller.meals.length - 1
                          ? LastItem(meal: controller.meals[index])
                          : MealWidget(meal: controller.meals[index]);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LastItem extends StatelessWidget {
  const LastItem({
    super.key,
    required this.meal,
  });

  final MealModel meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MealWidget(meal: meal),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.background,
                Theme.of(context).colorScheme.surface
              ],
            ),
          ),
          height: 250,
        ),
      ],
    );
  }
}
