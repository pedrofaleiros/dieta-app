import 'package:macros_app/src/features/home/data/dto/meal_dto.dart';
import 'package:macros_app/src/features/home/data/repository/meal_repository/create_meal_repository.dart';
import 'package:macros_app/src/features/home/data/repository/meal_repository/delete_meal_repository.dart';
import 'package:macros_app/src/features/home/data/repository/meal_repository/get_meals_repository.dart';
import 'package:macros_app/src/features/home/data/repository/meal_repository/update_meal_repository.dart';

import 'package:test/test.dart';

void main() {
  group('MealRepository', () {
    test(
      'Testando CRUD meal',
      () async {
        final createMealRepo = CreateMealRepository();
        final getMealsRepo = GetMealsRepository();
        final updateMealRepo = UpdateMealRepository();
        final deleteMealRepo = DeleteMealRepository();

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
          print('CREATE MEAL');
          var res = await createMealRepo.execute(
            body: newMeal.toMap(),
            token: token,
            queryParams: null,
          );
          expect(res.name, newMeal.name);

          final newMealId = res.id;

          print('UPDATE MEAL');
          res = await updateMealRepo.execute(
            body: updatedMeal.toMap(),
            queryParams: {"meal_id": newMealId},
            token: token,
          );
          expect(res.name, updatedMeal.name);
          expect(res.hour, updatedMeal.hour);

          print('DELETE MEAL');
          await deleteMealRepo.execute(
            body: null,
            queryParams: {"meal_id": newMealId},
            token: token,
          );

          print('GET MEALS');
          final list = await getMealsRepo.execute(
            body: null,
            queryParams: null,
            token: token,
          );
          expect(list[0].name, "Café da manhã");
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
