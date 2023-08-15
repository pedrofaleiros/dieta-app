// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MealViewmodel on _MealViewmodelBase, Store {
  late final _$mealsAtom =
      Atom(name: '_MealViewmodelBase.meals', context: context);

  @override
  ObservableList<MealModel> get meals {
    _$mealsAtom.reportRead();
    return super.meals;
  }

  @override
  set meals(ObservableList<MealModel> value) {
    _$mealsAtom.reportWrite(value, super.meals, () {
      super.meals = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_MealViewmodelBase.isLoading', context: context);

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

  late final _$setUserTokenAsyncAction =
      AsyncAction('_MealViewmodelBase.setUserToken', context: context);

  @override
  Future<void> setUserToken() {
    return _$setUserTokenAsyncAction.run(() => super.setUserToken());
  }

  late final _$getMealsAsyncAction =
      AsyncAction('_MealViewmodelBase.getMeals', context: context);

  @override
  Future<void> getMeals() {
    return _$getMealsAsyncAction.run(() => super.getMeals());
  }

  late final _$addMealAsyncAction =
      AsyncAction('_MealViewmodelBase.addMeal', context: context);

  @override
  Future<void> addMeal(String name, TimeOfDay time) {
    return _$addMealAsyncAction.run(() => super.addMeal(name, time));
  }

  late final _$deleteMealAsyncAction =
      AsyncAction('_MealViewmodelBase.deleteMeal', context: context);

  @override
  Future<void> deleteMeal(String mealId) {
    return _$deleteMealAsyncAction.run(() => super.deleteMeal(mealId));
  }

  @override
  String toString() {
    return '''
meals: ${meals},
isLoading: ${isLoading}
    ''';
  }
}
