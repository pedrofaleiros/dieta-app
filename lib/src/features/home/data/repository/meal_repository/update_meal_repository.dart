import 'package:macros_app/src/features/home/domain/model/converter/converter_interface.dart';
import 'package:macros_app/src/features/home/domain/model/converter/meal_model_converter.dart';
import 'package:macros_app/src/features/home/domain/model/meal_model.dart';
import 'package:macros_app/src/features/home/domain/repository/repository_interface.dart';
import 'package:macros_app/src/utils/dio_client.dart';


class UpdateMealRepository implements RepositoryInterface {
  @override
  IConverter converter = MealModelConverter();

  @override
  Future execute({
    required Map<String, dynamic>? body,
    required Map<String, dynamic>? queryParams,
    required String token,
  }) async {
    final dio = DioClient.getDioWithToken(token);
    const url = '${DioClient.baseUrl}/meal';

    final response = await dio.put(
      url,
      data: body,
      queryParameters: queryParams,
    );

    if (response.statusCode == 200) {
      MealModel meal = converter.fromMap(response.data);
      return meal;
    } else {
      throw Exception('erro ${response.statusCode}');
    }
  }
}
