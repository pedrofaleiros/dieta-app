import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macros_app/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class StatsTopWidget extends StatelessWidget {
  StatsTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MealViewmodel>();

    return Observer(
      builder: (_) => Column(
        children: [
          PieChart(
            chartRadius: 150,
            dataMap: controller.getTotalMacros(),
            colorList: [
              Theme.of(context).colorScheme.error,
              Color(0xff1565C0),
              Colors.amber,
            ],
          ),
          // Text(controller.getTotalKcals().toString()),
        ],
      ),
    );
  }
}
