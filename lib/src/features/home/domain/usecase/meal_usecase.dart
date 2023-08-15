import 'package:flutter/material.dart';
import 'package:macros_app/src/features/home/data/repository/meal_repository.dart';
import 'package:macros_app/src/features/home/domain/model/exceptions/invalid_token_exception.dart';
import 'package:macros_app/src/features/home/domain/repository/meal_repository_interface.dart';
import 'package:macros_app/src/utils/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/dto/meal_dto.dart';
import '../model/meal_model.dart';

class MealUsecase {
  IMealRepository repository = MealRepository();

  Future<List<MealModel>> getMeals(String? token) async {
    if (token == null) {
      throw InvalidTokenException('JWT token invalido');
    }

    try {
      final response = await repository.getMeals(token);

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
      final response = await repository.createMeal(token, newMeal);

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
      final response = await repository.deleteMeal(token, mealId);
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
