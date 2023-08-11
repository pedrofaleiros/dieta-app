import 'package:macros_app/src/features/auth/data/dto/user_dto.dart';
import 'package:macros_app/src/features/auth/domain/model/user_model.dart';

abstract class IAuthRepository {
  Future<UserModel> autoLogin();
  Future<UserModel> login(Map<String, String> data);
  Future<UserModel> signup(Map<String, String> data);
  Future<void> logout();
}
