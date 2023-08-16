import 'package:macros_app/src/features/home/data/dto/food_dto.dart';
import 'package:macros_app/src/features/home/domain/model/food_model.dart';

abstract class IFoodsRepository {
  Future<List<FoodModel>> getFoods(String token);

  Future<List<FoodModel>> searchFoods(String token, String name);

  Future<FoodModel> createFood(String token, FoodDTO newMeal);

  Future<void> deleteFood(String token, String foodId);
}
