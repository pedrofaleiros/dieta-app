import 'package:macros_app/src/features/auth/data/dto/user_dto.dart';
import 'package:macros_app/src/features/auth/domain/model/invalid_credentials_exception.dart';
import 'package:macros_app/src/features/auth/domain/model/user_model.dart';
import 'package:macros_app/src/features/auth/domain/usecase/auth_usecase.dart';
import 'package:mobx/mobx.dart';
part 'auth_viewmodel.g.dart';

class AuthViewModel = _AuthViewModelBase with _$AuthViewModel;

abstract class _AuthViewModelBase with Store {
  LoginError errors = LoginError();
  final AuthUsecase _usecase = AuthUsecase();

  @observable
  bool isAuthenticated = false;

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
      isAuthenticated = true;
    } catch (e) {
      // print('Erro autologin: ${e.toString()}');
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> login() async {
    isLoading = true;
    errors.validateLogin(authUser);

    if (errors.hasLoginErrors) {
      isLoading = false;
      return;
    }

    try {
      final user = await _usecase.login(authUser);

      sessionUser = user;
      isAuthenticated = true;
    } on InvalidCredentialsException catch (e) {
      errors.setLoginError(e.toString());
    } catch (e) {
      errors.setLoginError('Erro no servidor');
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> signup() async {}

  @action
  void logout() async {
    isLoading = true;

    try {
      await _usecase.logout();
      sessionUser = null;
      isAuthenticated = false;
      errors.clear();
      authUser = UserDTO(
        name: '',
        email: '',
        password: '',
      );
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }
}

class LoginError = _LoginErrorBase with _$LoginError;

abstract class _LoginErrorBase with Store {
  @observable
  String? email;

  @observable
  String? name;

  @observable
  String? password;

  @computed
  bool get hasLoginErrors => email != null || password != null;

  @computed
  bool get hasSignupErrors => name != null || email != null || password != null;

  @observable
  String? loginError;

  @action
  void setLoginError(String? value) {
    loginError = value;
    Future.delayed(const Duration(seconds: 3)).then((value) {
      loginError = null;
    });
  }

  @action
  void clear() {
    name = null;
    password = null;
    email = null;
    loginError = null;
  }

  @action
  void validateLogin(UserDTO user) {
    clear();

    if (!user.validateName()) {
      name = 'Username invalido';
    }

    if (!user.validatePassword()) {
      password = 'Senha invalida';
    }
  }

  @action
  void validateSignup(UserDTO user) {
    validateLogin(user);

    if (!user.validateEmail()) {
      email = 'Email invalido';
    }
  }
}
