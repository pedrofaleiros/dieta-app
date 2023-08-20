// meal_model_test.dart
import 'package:macros_app/src/features/home/domain/model/converter/meal_model_converter.dart';
import 'package:test/test.dart';
import 'package:macros_app/src/features/home/domain/model/food_model.dart';
import 'package:macros_app/src/features/home/domain/model/meal_model.dart';
import 'package:macros_app/src/features/home/domain/model/item_model.dart';

void main() {
  group('MealModel', () {
    test('testando conversões de MealModel', () {
      Map<String, dynamic> map = {
        'id': '1',
        'name': 'Lunch',
        'hour': 12,
        'minutes': 30,
        'items': [
          {
            'id': '1',
            'amount': 120,
            'food': {
              'id': '1',
              'kcal': 10.0,
              'carb': 10.0,
              'prot': 10.0,
              'fat': 10.0,
              'fiber': 10,
              'name': 'Rice',
              'liquid': false,
            },
          }
        ],
      };

      MealModelConverter converter = MealModelConverter();
      final MealModel meal = converter.fromMap(map) as MealModel;

      final FoodModel food = meal.items[0].food;
      final ItemModel item = meal.items[0];

      expect(meal.name, map['name']);
      expect(meal.hour, map['hour']);
      expect(meal.minutes, map['minutes']);
      expect(item.amount, map['items'][0]['amount']);
      expect(food.id, map['items'][0]['food']['id']);
      expect(food.liquid, map['items'][0]['food']['liquid']);
      expect(food.kcal, map['items'][0]['food']['kcal']);
      expect(food.carb, map['items'][0]['food']['carb']);
      expect(food.prot, map['items'][0]['food']['prot']);
      expect(food.fat, map['items'][0]['food']['fat']);
      expect(food.fiber, map['items'][0]['food']['fiber']);
      expect(food.name, map['items'][0]['food']['name']);
    });
  });
}
