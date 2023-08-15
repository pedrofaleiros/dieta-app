import 'package:macros_app/src/features/auth/data/dto/user_dto.dart';
import 'package:macros_app/src/features/auth/domain/model/invalid_credentials_exception.dart';
import 'package:macros_app/src/features/auth/domain/model/user_model.dart';
import 'package:macros_app/src/features/auth/domain/usecase/auth_usecase.dart';
import 'package:mobx/mobx.dart';

import 'login_error.dart';
part 'auth_viewmodel.g.dart';

class AuthViewModel = _AuthViewModelBase with _$AuthViewModel;

abstract class _AuthViewModelBase with Store {
  LoginError errors = LoginError();
  final AuthUsecase _usecase = AuthUsecase();

  @computed
  bool get isAuthenticated => sessionUser != null;

  @observable
  bool isLoading = false;

  @observable
  UserModel? sessionUser;

  @observable
  UserDTO authUser = UserDTO(
    name: '',
    email: '',
    password: '',
  );

  @action
  Future<void> autoLogin() async {
    isLoading = true;

    try {
      final user = await _usecase.autoLogin();

      sessionUser = user;
    } catch (e) {
      // print('Erro autologin: ${e.toString()}');
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> login() async {
    isLoading = true;
    errors.validateLogin(authUser);

    if (errors.hasLoginErrors) {
      isLoading = false;
      return false;
    }

    try {
      final user = await _usecase.login(authUser);
      sessionUser = user;
      return true;
    } on InvalidCredentialsException catch (e) {
      errors.setLoginError(e.toString());
    } catch (e) {
      errors.setLoginError('Erro no servidor');
    } finally {
      isLoading = false;
    }

    return false;
  }

  @action
  Future<void> logout() async {
    isLoading = true;

    try {
      await _usecase.logout();
      clearData();
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  void clearData() {
    sessionUser = null;
    errors.clear();
    authUser = UserDTO(
      name: '',
      email: '',
      password: '',
    );
  }

  @action
  Future<void> signup() async {}
}
