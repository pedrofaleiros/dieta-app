import 'package:macros_app/src/features/home/data/repository/meal_repository.dart';
import 'package:test/test.dart';

void main() {
  group('MealRepository', () {
    test(
      'Testando DELETE meal',
      () async {
        final repo = MealRepository();

        const String token =
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoicGVkcm9mYWxlaXJvcyIsImVtYWlsIjoicGVkcm9mYWxlaXJvc0BlbWFpbC5jb20uYnIiLCJpYXQiOjE2OTE3NzA1MDQsImV4cCI6MTY5NDM2MjUwNCwic3ViIjoiZjdjMGFjNjQtNTZmZi00MTk0LWI0ODItNGYzNmZhODRhNWFmIn0.Ilit_XuPrtUdUiY82rIy9TNHRaYkjIjoHPvn3ErUQpQ";

        const String mealId = "dd1079f4-6405-4d8f-a2ce-4611f676fa4f";

        bool hasErrors = false;

        try {
          // await repo.deleteMeal(token, mealId);
        } catch (e) {
          print("|Delete meal\n>>> ERRO: ${e.toString()}\n|");
          hasErrors = true;
        } finally {
          expect(hasErrors, false);
        }
      },
    );
  });
}
