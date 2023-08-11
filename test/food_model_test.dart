import 'package:macros_app/src/features/home/domain/model/food_model.dart';
import 'package:test/test.dart';

void main() {
  group('FoodModel', () {
    test('Testando conversoes map e json de FoodModel', () {
      Map<String, dynamic> map = {
        'id': '1',
        'kcal': 10.0,
        'carb': 10.0,
        'prot': 10.0,
        'fat': 10.0,
        'fiber': 10.0,
        'name': 'pedro',
        'liquid': true,
      };

      const String json = '{"id":"1","kcal":10.0,"carb":10.0,"prot":10.0,"fat":10.0,"fiber":10.0,"name":"pedro","liquid":true}';
      
      final FoodModel food = FoodModel.fromMap(map);
      final FoodModel fromJson = FoodModel.fromJson(json);
      final String foodToJson = food.toJson();
      final Map<String, dynamic> foodToMap = food.toMap();

      expect(food.id, map['id']);
      expect(food.name, map['name']);
      expect(food.kcal, map['kcal']);
      expect(food.carb, map['carb']);
      expect(food.prot, map['prot']);
      expect(food.fat, map['fat']);
      expect(food.fiber, map['fiber']);
      expect(food.liquid, map['liquid']);

      expect(fromJson.id, map['id']);
      expect(fromJson.name, map['name']);
      expect(fromJson.kcal, map['kcal']);
      expect(fromJson.carb, map['carb']);
      expect(fromJson.prot, map['prot']);
      expect(fromJson.fat, map['fat']);
      expect(fromJson.fiber, map['fiber']);
      expect(fromJson.liquid, map['liquid']);

      expect(foodToJson, json);

      expect(foodToMap, map);
    });
  });
}
