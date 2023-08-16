import 'dart:math';

import 'package:macros_app/src/features/home/data/dto/meal_dto.dart';
import 'package:macros_app/src/features/home/data/repository/meal_repository.dart';
import 'package:test/test.dart';

void main() {
  group('MealRepository', () {
    test(
      'Testando CRUD meal',
      () async {
        final repo = MealRepository();

        const String token =
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoicGVkcm9mYWxlaXJvcyIsImVtYWlsIjoicGVkcm9mYWxlaXJvc0BlbWFpbC5jb20uYnIiLCJpYXQiOjE2OTE3NzA1MDQsImV4cCI6MTY5NDM2MjUwNCwic3ViIjoiZjdjMGFjNjQtNTZmZi00MTk0LWI0ODItNGYzNmZhODRhNWFmIn0.Ilit_XuPrtUdUiY82rIy9TNHRaYkjIjoHPvn3ErUQpQ";

        final MealDTO newMeal = MealDTO(
          name: 'cafe da manha',
          hour: 8,
          minutes: 45,
        );

        final MealDTO updatedMeal = MealDTO(
          name: 'cafe da manha alterado',
          hour: 7,
          minutes: 45,
        );

        bool hasErrors = false;

        try {
          var res = await repo.createMeal(token, newMeal);
          expect(res.name, newMeal.name);

          final newMealId = res.id;

          res = await repo.updateMeal(token, updatedMeal, newMealId);
          expect(res.name, updatedMeal.name);
          expect(res.hour, updatedMeal.hour);

          await repo.deleteMeal(token, newMealId);
          await repo.getMeals(token);

        } catch (e) {
          print("|Create meal\n>>> ERRO: ${e.toString()}\n|");
          hasErrors = true;
        } finally {
          expect(hasErrors, false);
        }
      },
    );
  });
}
