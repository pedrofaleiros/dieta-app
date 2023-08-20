import 'package:flutter/material.dart';
import 'package:macros_app/src/features/home/domain/model/food_model.dart';
import 'package:macros_app/src/features/home/domain/model/item_model.dart';
import 'package:macros_app/src/features/home/domain/model/meal_model.dart';
import 'package:macros_app/src/features/home/domain/usecase/meal_usecase.dart';
import 'package:mobx/mobx.dart';
part 'meal_viewmodel.g.dart'; 

class MealViewmodel = _MealViewmodelBase with _$MealViewmodel;

abstract class _MealViewmodelBase with Store {
  final _usecase = MealUsecase();
  String? _userToken;

  @observable
  bool isLoading = false;

  @observable
  ObservableList<MealModel> meals = <MealModel>[].asObservable();

  @action
  Future<void> addFoodToMeal(
    String mealId,
    FoodModel food,
    double amount,
  ) async {
    isLoading = true;

    try {
      final response = await _usecase.addItem(mealId, food, amount, _userToken);

      int index = meals.indexWhere((element) => element.id == mealId);

      meals[index].addItem(response);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> deleteItem(
    String mealId,
    String itemId,
  ) async {
    isLoading = true;

    try {
      await _usecase.deleteItem(itemId, _userToken);

      for (var element in meals) {
        if (element.id == mealId) {
          element.deleteItem(itemId);
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> setUserToken() async {
    if (_userToken != null) {
      return;
    }

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
    // await Future.delayed(Duration(milliseconds: 300));

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

      includeMeal(newMeal);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
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

  // @computed
  Map<String, double> getTotalMacros() {
    double carb = 0;
    double prot = 0;
    double fats = 0;

    for (var meal in meals) {
      for (var item in meal.items) {
        carb += item.amount * item.food.carb / 100;
        prot += item.amount * item.food.prot / 100;
        fats += item.amount * item.food.fat / 100;
      }
    }

    return {
      "Carboidratos": carb,
      "Proteinas": prot,
      "Gorduras": fats,
    };
  }

  // @computed
  double getTotalKcals() {
    double kcal = 0;

    for (var meal in meals) {
      for (var item in meal.items) {
        kcal += item.amount * item.food.kcal / 100;
      }
    }

    return kcal;
  }

  @action
  void includeMeal(MealModel newMeal) {
    TimeOfDay timeNew = TimeOfDay(
      hour: newMeal.hour,
      minute: newMeal.minutes,
    );
    var i = 0;
    bool insert = false;
    while (i < meals.length) {
      TimeOfDay thisTime =
          TimeOfDay(hour: meals[i].hour, minute: meals[i].minutes);

      if (isBefore(timeNew, thisTime)) {
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
  }

  bool isBefore(TimeOfDay h1, TimeOfDay h2) {
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
}
