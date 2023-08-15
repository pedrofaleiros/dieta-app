// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthViewModel on _AuthViewModelBase, Store {
  Computed<bool>? _$isAuthenticatedComputed;

  @override
  bool get isAuthenticated =>
      (_$isAuthenticatedComputed ??= Computed<bool>(() => super.isAuthenticated,
              name: '_AuthViewModelBase.isAuthenticated'))
          .value;

  late final _$isLoadingAtom =
      Atom(name: '_AuthViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$sessionUserAtom =
      Atom(name: '_AuthViewModelBase.sessionUser', context: context);

  @override
  UserModel? get sessionUser {
    _$sessionUserAtom.reportRead();
    return super.sessionUser;
  }

  @override
  set sessionUser(UserModel? value) {
    _$sessionUserAtom.reportWrite(value, super.sessionUser, () {
      super.sessionUser = value;
    });
  }

  late final _$authUserAtom =
      Atom(name: '_AuthViewModelBase.authUser', context: context);

  @override
  UserDTO get authUser {
    _$authUserAtom.reportRead();
    return super.authUser;
  }

  @override
  set authUser(UserDTO value) {
    _$authUserAtom.reportWrite(value, super.authUser, () {
      super.authUser = value;
    });
  }

  late final _$autoLoginAsyncAction =
      AsyncAction('_AuthViewModelBase.autoLogin', context: context);

  @override
  Future<void> autoLogin() {
    return _$autoLoginAsyncAction.run(() => super.autoLogin());
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthViewModelBase.login', context: context);

  @override
  Future<bool> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  late final _$logoutAsyncAction =
      AsyncAction('_AuthViewModelBase.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$signupAsyncAction =
      AsyncAction('_AuthViewModelBase.signup', context: context);

  @override
  Future<void> signup() {
    return _$signupAsyncAction.run(() => super.signup());
  }

  late final _$_AuthViewModelBaseActionController =
      ActionController(name: '_AuthViewModelBase', context: context);

  @override
  void clearData() {
    final _$actionInfo = _$_AuthViewModelBaseActionController.startAction(
        name: '_AuthViewModelBase.clearData');
    try {
      return super.clearData();
    } finally {
      _$_AuthViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
sessionUser: ${sessionUser},
authUser: ${authUser},
isAuthenticated: ${isAuthenticated}
    ''';
  }
}
