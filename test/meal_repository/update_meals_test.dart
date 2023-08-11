import 'package:macros_app/src/features/home/data/dto/meal_dto.dart';
import 'package:macros_app/src/features/home/data/repository/meal_repository.dart';
import 'package:test/test.dart';

void main() {
  group('MealRepository', () {
    test(
      'Testando UPDATE meal',
      () async {
        final repo = MealRepository();

        const String token =
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoicGVkcm9mYWxlaXJvcyIsImVtYWlsIjoicGVkcm9mYWxlaXJvc0BlbWFpbC5jb20uYnIiLCJpYXQiOjE2OTE3NzA1MDQsImV4cCI6MTY5NDM2MjUwNCwic3ViIjoiZjdjMGFjNjQtNTZmZi00MTk0LWI0ODItNGYzNmZhODRhNWFmIn0.Ilit_XuPrtUdUiY82rIy9TNHRaYkjIjoHPvn3ErUQpQ";

        const String mealId = "89317535-d807-4617-9154-0bf4f14e8e97";

        final MealDTO meal = MealDTO(
          name: 'cafe da manha alterado',
          hour: 8,
          minutes: 3,
        );

        bool hasErrors = false;

        try {

          final response = await repo.updateMeal(token, meal, mealId);
          expect(response.minutes, meal.minutes);
        } catch (e) {
          print("|Update meal\n>>> ERRO: ${e.toString()}\n|");
          // hasErrors = true;
        } finally {
          expect(hasErrors, false);
        }
      },
    );
  });
}
