import 'package:dio/dio.dart';
import 'package:macros_app/src/features/home/data/dto/food_dto.dart';
import 'package:macros_app/src/features/home/domain/model/food_model.dart';
import 'package:macros_app/src/features/home/domain/repository/foods_repository_interface.dart';
import 'package:macros_app/src/utils/dio_client.dart';

class FoodsRepository implements IFoodsRepository {
  @override
  Future<List<FoodModel>> getFoods(String token) async {
    final dio = DioClient.getDioWithToken(token);

    try {
      const url = "${DioClient.baseUrl}/food";

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        final responseList = <FoodModel>[];

        for (var i = 0; i < data.length; i++) {
          FoodModel food = FoodModel.fromMap(data[i]);
          responseList.add(food);
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
  Future<FoodModel> createFood(String token, FoodDTO newMeal) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFood(String token, String foodId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<FoodModel>> searchFoods(String token, String name) async {
    final dio = DioClient.getDioWithToken(token);

    try {
      final url = "${DioClient.baseUrl}/food/search?name=$name";

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        final responseList = <FoodModel>[];

        for (var i = 0; i < data.length; i++) {
          FoodModel food = FoodModel.fromMap(data[i]);
          responseList.add(food);
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
}
