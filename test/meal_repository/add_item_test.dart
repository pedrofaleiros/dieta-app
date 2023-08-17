import 'dart:math';

import 'package:macros_app/src/features/home/data/dto/food_dto.dart';
import 'package:macros_app/src/features/home/data/dto/meal_dto.dart';
import 'package:macros_app/src/features/home/data/repository/meal_repository.dart';
import 'package:macros_app/src/features/home/domain/model/food_model.dart';
import 'package:test/test.dart';

void main() {
  group('MealRepository', () {
    test(
      'Testando CRUD meal',
      () async {
        final repo = MealRepository();

        const String token =
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoicGVkcm9mYWxlaXJvcyIsImVtYWlsIjoicGVkcm9mYWxlaXJvc0BlbWFpbC5jb20uYnIiLCJpYXQiOjE2OTE3NzA1MDQsImV4cCI6MTY5NDM2MjUwNCwic3ViIjoiZjdjMGFjNjQtNTZmZi00MTk0LWI0ODItNGYzNmZhODRhNWFmIn0.Ilit_XuPrtUdUiY82rIy9TNHRaYkjIjoHPvn3ErUQpQ";

        FoodModel food = FoodModel(
            id: "6879326a-b149-47eb-aa7c-d6fa30d73ebf",
            name: "Alcatra (Cru)",
            kcal: 158.0,
            carb: 0.0,
            prot: 20.0,
            fat: 7.0,
            fiber: 0.0,
            liquid: false);
        var mealId = "f0489cc2-70a4-4fdc-954a-ec092a425c24";
        double amount = 15.0;

        final response = await repo.addItem(mealId, food, amount, token);
        print(response.amount);
        print(response.food.id);
        print(response.id);
      },
    );
  });
}
