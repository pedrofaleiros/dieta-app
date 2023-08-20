import 'package:flutter/material.dart';
import 'package:macros_app/src/features/home/domain/model/meal_model.dart';

class MacrosCountWidget extends StatelessWidget {
  MacrosCountWidget({super.key, required this.meal});

  final MealModel meal;

  int kcal = 0;
  int carb = 0;
  int prot = 0;
  int fats = 0;

  void calculateMacros() {
    double dkcal = 0;
    double dcarb = 0;
    double dprot = 0;
    double dfats = 0;
    for (var item in meal.items) {
      dkcal += item.food.kcal * item.amount / 100;
      dprot += item.food.prot * item.amount / 100;
      dcarb += item.food.carb * item.amount / 100;
      dfats += item.food.fat * item.amount / 100;
    }

    kcal = dkcal.toInt();
    prot = dprot.toInt();
    carb = dcarb.toInt();
    fats = dfats.toInt();
  }

  @override
  Widget build(BuildContext context) {
    calculateMacros();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                '$carb g',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Carboidratos',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '$prot g',
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff1565C0),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Proteinas',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff1565C0),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '$fats g',
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xffFFC107),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Gorduras',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xffFFC107),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '$kcal',
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Kcals',
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
