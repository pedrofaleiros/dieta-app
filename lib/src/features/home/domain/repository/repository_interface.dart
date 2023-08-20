import 'package:macros_app/src/features/home/domain/model/converter/converter_interface.dart';

abstract class RepositoryInterface<T> {
  late IConverter converter;

  Future<T> execute({
    required Map<String, dynamic>? body,
    required Map<String, dynamic>? queryParams,
    required String token,
  });
}
