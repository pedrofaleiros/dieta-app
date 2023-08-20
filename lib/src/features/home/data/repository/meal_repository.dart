import 'package:dio/dio.dart';
import 'package:macros_app/src/features/home/domain/model/food_model.dart';
import 'package:macros_app/src/features/home/domain/model/item_model.dart';
import 'package:macros_app/src/utils/dio_client.dart';

import '../../domain/model/converter/meal_model_converter.dart';

class MealRepository {
  final conv = MealModelConverter();

  Future<ItemModel> addItem(
    String mealId,
    FoodModel food,
    double amount,
    String token,
  ) async {
    final dio = DioClient.getDioWithToken(token);

    try {
      final data = {
        "meal_id": mealId,
        "food_id": food.id,
        "amount": amount,
      };

      const url = '${DioClient.baseUrl}/item';

      final response = await dio.post(
        url,
        data: data,
      );

      if (response.statusCode == 200) {
        ItemModel newItem = ItemModel(
          id: response.data["id"],
          food: food,
          amount: double.parse(response.data["amount"].toString()),
        );

        return newItem;
      } else {
        throw Exception('erro ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw DioClient.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteItem(String itemId, String token) async {
    final dio = DioClient.getDioWithToken(token);

    try {
      final url = '${DioClient.baseUrl}/item?item_id=$itemId';

      final response = await dio.delete(
        url,
      );

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
}
