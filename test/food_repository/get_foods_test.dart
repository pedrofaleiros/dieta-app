import 'package:macros_app/src/features/home/data/repository/foods_repository.dart';
import 'package:macros_app/src/features/home/data/repository/meal_repository.dart';
import 'package:test/test.dart';

void main() {
  group('FoodsRepository', () {
    test(
      'Testando GET foods',
      () async {
        bool hasErrors = false;

        final repo = FoodsRepository();
        const String token =
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoicGVkcm9mYWxlaXJvcyIsImVtYWlsIjoicGVkcm9mYWxlaXJvc0BlbWFpbC5jb20uYnIiLCJpYXQiOjE2OTIxODk0MjQsImV4cCI6MTY5NDc4MTQyNCwic3ViIjoiZjdjMGFjNjQtNTZmZi00MTk0LWI0ODItNGYzNmZhODRhNWFmIn0.4p6Bveq0EELkEEjUM2qhxTJ2LV8SCvOxih2CFgkFW8s';

        try {
          final respose = await repo.getFoods(token);

          respose.forEach((element) {
            print(element.name);
          });

        } catch (e) {
          print("|Get meal\n>>> ERRO: ${e.toString()}\n|");
          hasErrors = true;
        } finally {
          expect(hasErrors, false);
        }
      },
    );
  });
}
