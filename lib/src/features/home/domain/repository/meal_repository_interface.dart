import 'package:macros_app/src/features/home/data/dto/meal_dto.dart';
import 'package:macros_app/src/features/home/domain/model/meal_model.dart';

abstract class IMealRepository {
  Future<List<MealModel>> getMeals(String token);

  Future<MealModel> createMeal(String token, MealDTO newMeal);

  Future<MealModel> updateMeal(String token, MealDTO updatedMeal, String mealId);

  Future<void> deleteMeal(String token, String mealId);
}
