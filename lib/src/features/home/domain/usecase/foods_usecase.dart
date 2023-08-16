import 'package:macros_app/src/features/home/data/repository/foods_repository.dart';
import 'package:macros_app/src/features/home/domain/model/food_model.dart';
import 'package:macros_app/src/features/home/domain/repository/foods_repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/shared_preferences_keys.dart';
import '../model/exceptions/invalid_token_exception.dart';

class FoodsUsecase {
  IFoodsRepository repository = FoodsRepository();

  Future<List<FoodModel>> getFoods(String? token) async {
    if (token == null) {
      throw InvalidTokenException('JWT token invalido');
    }

    try {
      final response = await repository.getFoods(token);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<FoodModel>> searchFoods(String? token, String name) async {
    if (token == null) {
      throw InvalidTokenException('JWT token invalido');
    }

    try {
      List<FoodModel> response;
      if (name == '') {
        response = await repository.getFoods(token);
      } else {
        response = await repository.searchFoods(token, name);
      }

      return response;
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
