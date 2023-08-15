import 'package:flutter/material.dart';
import 'package:macros_app/src/features/home/domain/model/meal_model.dart';
import 'package:macros_app/src/features/home/domain/usecase/meal_usecase.dart';
import 'package:mobx/mobx.dart';
part 'meal_viewmodel.g.dart';

class MealViewmodel = _MealViewmodelBase with _$MealViewmodel;

abstract class _MealViewmodelBase with Store {
  final _usecase = MealUsecase();
  String? _userToken;

  @observable
  ObservableList<MealModel> meals = <MealModel>[].asObservable();

  @observable
  bool isLoading = false;

  @action
  Future<void> setUserToken() async {
    if (_userToken != null) {
      return;
    }
    print('chamando setUserToken');

    try {
      final token = await _usecase.getToken();

      _userToken = token;
    } catch (e) {
      print(e.toString());
    }
  }

  @action
  Future<void> getMeals() async {
    isLoading = true;
    await Future.delayed(Duration(milliseconds: 300));

    try {
      final response = await _usecase.getMeals(_userToken);

      meals.clear();

      for (var element in response) {
        meals.add(element);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> addMeal(String name, TimeOfDay time) async {
    isLoading = true;

    try {
      final newMeal = await _usecase.createMeal(_userToken, name, time);

      //incluir ordenado por hora
      TimeOfDay timeNew = TimeOfDay(
        hour: newMeal.hour,
        minute: newMeal.minutes,
      );
      var i = 0;
      bool insert = false;
      while (i < meals.length) {
        TimeOfDay thisTime = TimeOfDay(hour: meals[i].hour, minute: meals[i].minutes);
        
        if (vemAntes(timeNew, thisTime)) {
          meals.insert(i, newMeal);
          insert = true;
          break;
        } else {
          i++;
        }
      }
      if (!insert) {
        meals.add(newMeal);
      }
      //---------------------------------
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }

  bool vemAntes(TimeOfDay h1, TimeOfDay h2) {
    if (h1.hour == h2.hour) {
      if (h1.minute < h2.minute) {
        return true;
      } else {
        return false;
      }
    }

    if (h1.hour < h2.hour) {
      return true;
    }

    return false;
  }

  @action
  Future<void> deleteMeal(String mealId) async {
    isLoading = true;

    try {
      await _usecase.deleteMeal(_userToken, mealId);

      meals.removeWhere((element) => element.id == mealId);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }
}