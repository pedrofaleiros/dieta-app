import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macros_app/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class StatsTopWidget extends StatelessWidget {
  const StatsTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MealViewmodel>();
    int kcal = controller.getTotalKcals().toInt();
    Map<String, double> data = controller.getTotalMacros();

    var colorList = [
      const Color(0xff1565C0),
      Theme.of(context).colorScheme.error,
      Colors.amber,
    ];
    return Column(
      children: [
        PieChart(
          legendOptions: const LegendOptions(
            showLegends: false,
          ),
          chartRadius: 150,
          dataMap: data,
          colorList: colorList,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Carboidratos: ${data['Carboidratos']!.toInt()} g",
              style: TextStyle(
                color: colorList[1],
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              "Proteínas: ${data['Proteinas']!.toInt()} g",
              style: TextStyle(
                color: colorList[0],
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              "Gorduras: ${data['Gorduras']!.toInt()} g",
              style: TextStyle(
                color: colorList[2],
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Text(
          "$kcal Kcals",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
