import 'package:macros_app/src/features/auth/domain/model/auth_exception.dart';
import 'package:macros_app/src/features/auth/domain/model/invalid_credentials_exception.dart';
import 'package:macros_app/src/features/auth/domain/model/user_model.dart';
import 'package:macros_app/src/features/auth/domain/model/user_not_found_exception.dart';
import 'package:macros_app/src/features/auth/domain/repository/auth_repository_interface.dart';
import 'package:dio/dio.dart';
import 'package:macros_app/src/utils/dio_client.dart';
import 'package:macros_app/src/utils/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository implements IAuthRepository {
  @override
  Future<UserModel> autoLogin() async {

    try {
      final shared = await SharedPreferences.getInstance();

      final token = shared.getString(SPK.USER_LOGGED_KEY);

      if (token == null) {
        throw UserNotFoundException('Nenhum usuario logado');
      }

      final dio = DioClient.getDio();

      dio.options.headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };
      final response = await dio.get(
        '${DioClient.baseUrl}/me',
      );

      if (response.statusCode == 200) {
        final user = UserModel.fromMapWithToken(
          response.data,
          token,
        );
        return user;
      } else {
        throw AuthException("ERRO");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> login(Map<String, String> data) async {
    final dio = DioClient.getDio();

    try {
      final response = await dio.post(
        '${DioClient.baseUrl}/session-name',
        data: data,
      );

      if (response.statusCode == 200) {
        final shared = await SharedPreferences.getInstance();

        final userToken = response.data['token'] as String;

        if (userToken.isNotEmpty) {
          await shared.setString(SPK.USER_LOGGED_KEY, userToken);
        }

        return UserModel.fromMap(response.data);
      } else {
        throw AuthException("ERRO");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          throw InvalidCredentialsException('Credenciais invalidas');
        }
      }
      throw AuthException(e.toString());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    final shared = await SharedPreferences.getInstance();

    if (!await shared.remove(SPK.USER_LOGGED_KEY)) {
      throw AuthException('Erro ao apagar');
    }
  }

  @override
  Future<UserModel> signup(Map<String, String> data) async {
    throw UnimplementedError();
  }
}
