import 'package:macros_app/src/features/home/domain/model/converter/converter_interface.dart';
import 'package:macros_app/src/features/home/domain/model/converter/meal_model_converter.dart';
import 'package:macros_app/src/features/home/domain/repository/repository_interface.dart';

import '../../../../../utils/dio_client.dart';

class DeleteMealRepository implements RepositoryInterface {
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
    final response = await dio.delete(
      url,
      data: body,
      queryParameters: queryParams,
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Erro ${response.statusCode}');
    }
  }
}
