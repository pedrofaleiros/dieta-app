import 'package:dio/dio.dart';
import 'package:macros_app/src/features/auth/data/repository/auth_repository.dart';
import 'package:macros_app/src/features/auth/domain/model/auth_exception.dart';
import 'package:macros_app/src/features/auth/domain/model/user_model.dart';
import 'package:macros_app/src/features/auth/domain/model/user_not_found_exception.dart';
import 'package:macros_app/src/features/auth/domain/repository/auth_repository_interface.dart';

import '../../data/dto/user_dto.dart';

class AuthUsecase {
  IAuthRepository repository = AuthRepository();

  Future<UserModel> autoLogin() async {
    try {
      final user = await repository.autoLogin();
      return user;
    } on UserNotFoundException {
      rethrow;
    } on DioException catch (e) {
      throw AuthException('Servidor nao respondeu');
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> login(UserDTO user) async {
    final data = {
      'name': user.name,
      'password': user.password,
    };
    final response = await repository.login(data);

    return response;
  }

  Future<UserModel> signup(UserDTO user) async {
    return UserModel(id: 'id', name: 'name', email: 'email', token: '');
  }

  Future<void> logout() async {
    try {
      await repository.logout();
    } catch (e) {
      rethrow;
    }
  }
}
