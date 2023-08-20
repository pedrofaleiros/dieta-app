import 'package:flutter/material.dart';
import 'package:macros_app/src/features/home/data/repository/meal_repository.dart';
import 'package:macros_app/src/features/home/data/repository/meal_repository/create_meal_repository.dart';
import 'package:macros_app/src/features/home/data/repository/meal_repository/delete_meal_repository.dart';
import 'package:macros_app/src/features/home/data/repository/meal_repository/get_meals_repository.dart';
import 'package:macros_app/src/features/home/domain/model/exceptions/invalid_token_exception.dart';
import 'package:macros_app/src/features/home/domain/model/food_model.dart';
import 'package:macros_app/src/features/home/domain/model/item_model.dart';
import 'package:macros_app/src/utils/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/dto/meal_dto.dart';
import '../model/meal_model.dart';

class MealUsecase {
  MealRepository repository = MealRepository();

  Future<ItemModel> addItem(
    String mealId,
    FoodModel food,
    double amount,
    String? token,
  ) async {
    if (token == null) {
      throw InvalidTokenException('JWT token invalido');
    }

    try {
      final response = await repository.addItem(mealId, food, amount, token);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteItem(
    String itemId,
    String? token,
  ) async {
    if (token == null) {
      throw InvalidTokenException('JWT token invalido');
    }

    try {
      await repository.deleteItem(itemId, token);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MealModel>> getMeals(String? token) async {
    if (token == null) {
      throw InvalidTokenException('JWT token invalido');
    }

    try {
      final repo = GetMealsRepository();
      final response = await repo.execute(
        body: null,
        queryParams: null,
        token: token,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<MealModel> createMeal(
    String? token,
    String name,
    TimeOfDay time,
  ) async {
    if (token == null) {
      throw InvalidTokenException('JWT token invalido');
    }

    MealDTO newMeal = MealDTO(
      name: name,
      hour: time.hour,
      minutes: time.minute,
    );

    try {
      final repo = CreateMealRepository();
      final response = await repo.execute(
        body: newMeal.toMap(),
        queryParams: null,
        token: token,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<MealModel> updateMeal(
      String token, MealDTO updatedMeal, String mealId) async {
    throw UnimplementedError();
  }

  Future<void> deleteMeal(String? token, String mealId) async {
    if (token == null) {
      throw InvalidTokenException('JWT token invalido');
    }

    try {
      final repo = DeleteMealRepository();
      await repo.execute(
        body: null,
        queryParams: {"meal_id": mealId},
        token: token,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    final shared = await SharedPreferences.getInstance();

    try {
      final token = shared.getString(SPK.USER_LOGGED_KEY);

      if (token == null) {
        throw InvalidTokenException('Token not found');
      }

      return token;
    } catch (e) {
      rethrow;
    }
  }
}
