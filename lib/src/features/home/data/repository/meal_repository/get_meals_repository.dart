import 'package:macros_app/src/features/home/domain/model/meal_model.dart';
import 'package:macros_app/src/features/home/domain/repository/repository_interface.dart';
import 'package:macros_app/src/utils/dio_client.dart';

import '../../../domain/model/converter/converter_interface.dart';
import '../../../domain/model/converter/meal_model_converter.dart';

class GetMealsRepository implements RepositoryInterface<List<MealModel>> {
  @override
  IConverter converter = MealModelConverter();

  @override
  Future<List<MealModel>> execute({
    required Map<String, dynamic>? body,
    required Map<String, dynamic>? queryParams,
    required String token,
  }) async {
    final dio = DioClient.getDioWithToken(token);
    const url = "${DioClient.baseUrl}/meal";

    final response = await dio.get(
      url,
      data: body,
      queryParameters: queryParams,
    );

    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;

      List<MealModel> list = converter.getList(data) as List<MealModel>;
      return list;
    } else {
      throw Exception('Erro ${response.statusCode}');
    }
  }
}
