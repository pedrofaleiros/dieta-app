import 'package:dio/dio.dart';
import 'package:macros_app/src/features/home/data/dto/meal_dto.dart';
import 'package:macros_app/src/features/home/domain/model/meal_model.dart';
import 'package:macros_app/src/features/home/domain/model/not_authorized_exception.dart';
import 'package:macros_app/src/features/home/domain/repository/meal_repository_interface.dart';
import 'package:macros_app/src/utils/dio_client.dart';

class MealRepository implements IMealRepository {
  final conv = MealModelConverter();

  @override
  Future<MealModel> createMeal(String token, MealDTO newMeal) async {
    final dio = DioClient.getDioWithToken(token);

    try {
      final data = newMeal.toMap();

      const url = '${DioClient.baseUrl}/meal';

      final response = await dio.post(
        url,
        data: data,
      );

      if (response.statusCode == 200) {
        MealModel meal = conv.fromMap(response.data);
        return meal;
      } else {
        throw Exception('erro ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw DioClient.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MealModel>> getMeals(String token) async {
    final dio = DioClient.getDioWithToken(token);

    try {
      const url = "${DioClient.baseUrl}/meal";
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        final responseList = <MealModel>[];

        for (var i = 0; i < data.length; i++) {
          MealModel meal = conv.fromMap(data[i]);
          responseList.add(meal);
        }

        return responseList;
      } else {
        throw Exception('erro ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw DioClient.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteMeal(String token, String mealId) async {
    final dio = DioClient.getDioWithToken(token);

    try {
      final url = '${DioClient.baseUrl}/meal?meal_id=$mealId';
      final response = await dio.delete(url);

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('erro ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw DioClient.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MealModel> updateMeal(
    String token,
    MealDTO updatedMeal,
    String mealId,
  ) async {
    final dio = DioClient.getDioWithToken(token);

    try {
      final data = updatedMeal.toMap();

      final url = '${DioClient.baseUrl}/meal?meal_id=$mealId';

      final response = await dio.put(
        url,
        data: data,
      );

      if (response.statusCode == 200) {
        MealModel meal = conv.fromMap(response.data);
        return meal;
      } else {
        throw Exception('erro ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw DioClient.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }
}
